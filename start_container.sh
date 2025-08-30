#!/bin/bash

print_help() {
	echo "usage: $0 compiler src_dir out_dir [-h] [-d | -p] [-n] [-e VAR] [-v] [-- cmd with args]"
	echo "  -h    print this help"
	echo "  -d    force to use the Docker container engine (default)"
	echo "  -p    force to use the Podman container engine instead of default Docker"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    add environment variable in the container (may be used multiple times)"
	echo "  -v    enable debug output"
	echo ""
	echo "  If cmd is empty, we will start an interactive bash in the container."
}

set -eu

if [ $# -lt 3 ]; then
	print_help
	exit 1
fi

COMPILER=$1
SRC="$2"
OUT="$3"
shift 3

# defaults
CIDFILE=""
ENV=""
INTERACTIVE="-it"
RUNTIME=""
RUNTIME_ARGS=""
SUDO_CMD=""

while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		print_help
		exit 0
		;;
	-d |--docker)
		if [ "$RUNTIME" != "" ]; then
			echo "ERROR: Multiple container engines specified" >&2
			exit 1
		else
			echo "Force to use the Docker container engine"
			RUNTIME="docker"
		fi
		shift
		;;
	-p |--podman)
		if [ "$RUNTIME" != "" ]; then
			echo "ERROR: Multiple container engines specified" >&2
			exit 1
		else
			echo "Force to use the Podman container engine"
			RUNTIME="podman"
			RUNTIME_ARGS="--userns=keep-id"
		fi
		shift
		;;
	-n | --non-interactive)
		INTERACTIVE=""
		CIDFILE="--cidfile $OUT/container.id"
		echo "Gonna run the container in NON-interactive mode"
		shift
		;;
	-e | --env)
		# `set -eu` will prevent out-of-bounds access
		ENV="$ENV -e $2"
		shift 2
		;;
	-v | --verbose)
		set -x
		shift
		;;
	--)
		shift
		break
		;;
	*)
		echo "ERROR: Unknown option $1"
		print_help
		exit 1
		;;
	esac
done

if [ -z "$RUNTIME" ]; then
	echo "Docker container engine is chosen (default)"
	RUNTIME="docker"
fi

set +e
RUNTIME_TEST_OUTPUT="$($RUNTIME ps 2>&1)"
set -e

if echo "$RUNTIME_TEST_OUTPUT" | grep -qi "permission denied"; then
	echo "Hey, we gonna use sudo for running the container"
	SUDO_CMD="sudo"
fi

echo "Starting \"kernel-build-container:$COMPILER\""

if [ ! -z "$ENV" ]; then
	echo "Container environment arguments: $ENV"
fi

if [ ! -z $INTERACTIVE ]; then
	echo "Gonna run the container in interactive mode"
fi

echo "Mount source code directory \"$SRC\" at \"/src\""
echo "Mount build output directory \"$OUT\" at \"/out\""

if [ $# -gt 0 ]; then
	echo -e "Gonna run command \"$@\"\n"
else
	echo -e "Gonna run bash\n"
fi

# Z for setting SELinux label
exec $SUDO_CMD $RUNTIME run $ENV $INTERACTIVE $CIDFILE $RUNTIME_ARGS --rm \
	-v $SRC:/src:Z \
	-v $OUT:/out:Z \
	kernel-build-container:$COMPILER "$@"
