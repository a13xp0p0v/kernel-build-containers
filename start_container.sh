#!/bin/bash

print_help() {
	echo "usage: $0 compiler src_dir out_dir [-n] [-e VAR] [-h] [-v] [-p | -d] [-- cmd with args]"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    add environment variable in the container (may be used multiple times)"
	echo "  -h    print this help"
	echo "  -v    enable debug output"
	echo "  -p    use podman runtime"
	echo "  -d    use docker runtime"
	echo ""
	echo "  If cmd is empty, we will start an interactive bash in the container."
}

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
SUDO_CMD=""
PODMAN_CMD=""

while [[ $# -gt 0 ]]; do
	case $1 in
	-n | --non-interactive)
		INTERACTIVE=""
		CIDFILE="--cidfile $OUT/container.id"
		echo "Run image runtime engine in NON-interactive mode"
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
	-p |--podman)
		if [ "$RUNTIME" != "" ]; then
			echo "Multiple image runtime engines specified" >&2
			exit 1
		else
			RUNTIME="podman"
		fi
		shift
		;;
	-d |--docker)
		if [ "$RUNTIME" != "" ]; then
			echo "Multiple image runtime engines specified" >&2
			exit 1
		else
			RUNTIME="docker"
		fi
		shift
		;;
	-h | --help)
		print_help
		exit 0
		;;
	--)
		shift
		break
		;;
	*)
		echo "Unknown option $1"
		print_help
		exit 1
		;;
	esac
done

if [ -z "$RUNTIME" ]; then
	echo "Please use --podman / --docker flags" >&2
	exit 1
fi

output=$($RUNTIME ps 2>&1)
set -eu

if [ "$RUNTIME" = "podman" ]; then
	if [ "$EUID" -eq 0 ]; then
		echo "Dont use podman with sudo, it's rootless!" >&2
		exit 1
	fi
	echo "Hey, you are running podman as $USERNAME ($(id -u))"
	PODMAN_CMD="--userns=keep-id"
elif [ "$RUNTIME" = "docker" ]; then
	if echo "$output" | grep -qi "CONTAINER ID"; then
		echo "Enough permissions to run docker, sudo is not needed"
	elif echo "$output" | grep -qi "permission denied"; then
		echo "Hey, we gonna use sudo for running docker"
		SUDO_CMD="sudo"
	fi
else
	echo "Unexpected state" >&2
	exit 1
fi

echo "Starting \"kernel-build-container:$COMPILER\""

if [ ! -z "$ENV" ]; then
	echo "Container environment arguments: $ENV"
fi

if [ ! -z $INTERACTIVE ]; then
	echo "Gonna run $RUNTIME in interactive mode"
fi

echo "Mount source code directory \"$SRC\" at \"/src\""
echo "Mount build output directory \"$OUT\" at \"/out\""

if [ $# -gt 0 ]; then
	echo -e "Gonna run command \"$@\"\n"
else
	echo -e "Gonna run bash\n"
fi

# Z for setting SELinux label
exec $SUDO_CMD $RUNTIME run $ENV $INTERACTIVE $CIDFILE $PODMAN_CMD --rm \
	-v $SRC:/src:Z \
	-v $OUT:/out:Z \
	kernel-build-container:$COMPILER "$@"
