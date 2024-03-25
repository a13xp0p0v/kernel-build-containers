#!/bin/bash

print_help() {
	echo "usage: $0 compiler src_dir out_dir [-n] [-e VAR] [-h] [-v] [-- cmd with args]"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    add environment variable in the container (may be used multiple times)"
	echo "  -h    print this help"
	echo "  -v    enable debug output"
	echo ""
	echo "  If cmd is empty, we will start an interactive bash in the container."
}

groups | grep docker
NEED_SUDO=$?

set -eu

if [ $NEED_SUDO -eq 1 ]; then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

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

while [[ $# -gt 0 ]]; do
	case $1 in
	-n | --non-interactive)
		INTERACTIVE=""
		CIDFILE="--cidfile $OUT/container.id"
		echo "Run docker in NON-interactive mode"
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

echo "Starting \"kernel-build-container:$COMPILER\""

if [ ! -z "$ENV" ]; then
	echo "Container environment arguments: $ENV"
fi

if [ ! -z $INTERACTIVE ]; then
	echo "Gonna run docker in interactive mode"
fi

echo "Mount source code directory \"$SRC\" at \"/home/$(id -nu)/src\""
echo "Mount build output directory \"$OUT\" at \"/home/$(id -nu)/out\""

if [ $# -gt 0 ]; then
	echo -e "Gonna run command \"$@\"\n"
else
	echo -e "Gonna run bash\n"
fi

# Z for setting SELinux label
exec $SUDO_CMD docker run $ENV $INTERACTIVE $CIDFILE --rm \
	-v $SRC:/home/$(id -nu)/src:Z \
	-v $OUT:/home/$(id -nu)/out:Z \
	kernel-build-container:$COMPILER "$@"
