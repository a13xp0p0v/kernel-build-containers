#!/bin/bash

set -eu

print_help() {
	echo "usage: $0 compiler src_dir out_dir [-h] [-d | -p] [-n] [-e VAR] [-v] [-m CCACHE_DIR] [-M SIZE] [-- cmd with args]"
	echo "  -h    print this help"
	echo "  -d    force to use the Docker container engine (default)"
	echo "  -p    force to use the Podman container engine instead of default Docker"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    add environment variable in the container (may be used multiple times)"
	echo "  -v    enable debug output"
	echo "  -m    mount the ccache directory from the host and enable ccache in the container"
	echo "  -M    set the ccache max size, e.g. 10G (0 means unlimited); requires -m"
	echo ""
	echo "  If cmd is empty, we will start an interactive bash in the container."
}

if [ $# -lt 3 ]; then
	print_help
	exit 1
fi

COMPILER="$1"
SRC="$2"
OUT="$3"
shift 3

# defaults
CIDFILE=""
ENV=""
INTERACTIVE="-it"
RUNTIME=""
RUNTIME_SPECIFIC_ARGS=""
SUDO_CMD=""
CCACHE_DIR=""
CCACHE_MAX_SIZE=""

while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		print_help
		exit 0
		;;
	-d | --docker)
		if [ "$RUNTIME" != "" ]; then
			echo "[-] ERROR: Multiple container engines specified" >&2
			exit 1
		else
			echo "Force to use the Docker container engine"
			RUNTIME="docker"
		fi
		shift
		;;
	-p | --podman)
		if [ "$RUNTIME" != "" ]; then
			echo "[-] ERROR: Multiple container engines specified" >&2
			exit 1
		else
			echo "Force to use the Podman container engine"
			echo "[!] INFO: Working with Podman images belonging to \"$(id -un)\" (UID $(id -u))"
			RUNTIME="podman"
			RUNTIME_SPECIFIC_ARGS="--userns=keep-id --net=pasta:--ipv4-only"
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
	-m | --mount-ccache)
		# `set -eu` will prevent out-of-bounds access
		CCACHE_DIR="$2"
		shift 2
		;;
	-M | --ccache-max-size)
		# `set -eu` will prevent out-of-bounds access
		CCACHE_MAX_SIZE="$2"
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
		echo "[-] ERROR: Unknown option $1"
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

if [ ! -z "$INTERACTIVE" ]; then
	echo "Gonna run the container in interactive mode"
fi

echo "Mount source code directory \"$SRC\" at \"/src\""
echo "Mount build output directory \"$OUT\" at \"/out\""

if [ -n "$CCACHE_MAX_SIZE" ]; then
	if [ -z "$CCACHE_DIR" ]; then
		echo "[-] ERROR: -M requires -m (ccache is disabled without a mounted directory)" >&2
		exit 1
	fi
	if ! [[ "$CCACHE_MAX_SIZE" =~ ^[0-9]+(\.[0-9]+)?[KMGTkmgt]?$ ]]; then
		echo "[-] ERROR: Invalid ccache max size \"$CCACHE_MAX_SIZE\", expected e.g. 10G or 0" >&2
		exit 1
	fi
fi

if [ -n "$CCACHE_DIR" ]; then
	mkdir -p "$CCACHE_DIR"
	echo "Mount ccache directory \"$CCACHE_DIR\" at \"~/.cache/ccache\" and enable ccache"
	# The /usr/lib/ccache directory contains the ccache symlinks for the compilers
	ENV="$ENV -e PATH=/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
	if [ -n "$CCACHE_MAX_SIZE" ]; then
		echo "Set the ccache max size to \"$CCACHE_MAX_SIZE\""
		ENV="$ENV -e CCACHE_MAXSIZE=$CCACHE_MAX_SIZE"
	fi
fi

if [ $# -gt 0 ]; then
	echo -e "Gonna run command \"$@\"\n"
else
	echo -e "Gonna run bash\n"
fi

# Z for setting SELinux label
exec $SUDO_CMD $RUNTIME run $ENV $INTERACTIVE $CIDFILE $RUNTIME_SPECIFIC_ARGS --pull=never --rm \
	-v $SRC:/src:Z \
	-v $OUT:/out:Z \
	${CCACHE_DIR:+-v $CCACHE_DIR:/home/$(id -un)/.cache/ccache:Z} \
	kernel-build-container:$COMPILER "$@"
