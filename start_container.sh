#!/bin/bash

set -eu

print_help() {
	echo "usage: $0 compiler src_dir out_dir [-h] [-d | -p] [-n] [-e VAR] [-v] [-c CCACHE_DIR] [-- cmd with args]"
	echo "  -h    print this help"
	echo "  -d    force to use the Docker container engine (default)"
	echo "  -p    force to use the Podman container engine instead of default Docker"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    add environment variable in the container (may be used multiple times)"
	echo "  -v    enable debug output"
	echo "  -c    specify ccache directory (default: \$HOME/.cache/kernel-build-containers/ccache)"
	echo "        can also be set via CCACHE_DIR environment variable"
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
CCACHE_DIR="${CCACHE_DIR:-$HOME/.cache/kernel-build-containers/ccache}"

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
	-c | --ccache-dir)
		# `set -eu` will prevent out-of-bounds access
		CCACHE_DIR="$2"
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

# Create ccache directory if it doesn't exist
if [ ! -d "$CCACHE_DIR" ]; then
	echo "Creating ccache directory \"$CCACHE_DIR\""
	mkdir -p "$CCACHE_DIR"

	# Inherit ccache configuration from host's ccache config
	# Check both possible locations: ~/.config/ccache/ccache.conf and ~/.cache/ccache/ccache.conf
	HOST_CCACHE_CONF=""
	if [ -f "$HOME/.config/ccache/ccache.conf" ]; then
		HOST_CCACHE_CONF="$HOME/.config/ccache/ccache.conf"
	elif [ -f "$HOME/.cache/ccache/ccache.conf" ]; then
		HOST_CCACHE_CONF="$HOME/.cache/ccache/ccache.conf"
	fi

	if [ -n "$HOST_CCACHE_CONF" ] && [ "$CCACHE_DIR" != "$HOME/.cache/ccache" ]; then
		echo "Inheriting ccache configuration from host ($HOST_CCACHE_CONF)"
		cp "$HOST_CCACHE_CONF" "$CCACHE_DIR/ccache.conf"
	else
		# Set unlimited cache size by default if no host config exists
		echo "Setting ccache max_size to unlimited (0)"
		ccache -d "$CCACHE_DIR" --max-size 0 > /dev/null 2>&1 || true
	fi
fi

echo "Mount ccache directory \"$CCACHE_DIR\" at \"~/.cache/ccache\""

if [ $# -gt 0 ]; then
	echo -e "Gonna run command \"$@\"\n"
else
	echo -e "Gonna run bash\n"
fi

# Z for setting SELinux label
# Mount ccache at the default location inside the container so it's automatically used
exec $SUDO_CMD $RUNTIME run $ENV $INTERACTIVE $CIDFILE $RUNTIME_SPECIFIC_ARGS --pull=never --rm \
	-v $SRC:/src:Z \
	-v $OUT:/out:Z \
	-v $CCACHE_DIR:/home/$(id -un)/.cache/ccache:Z \
	kernel-build-container:$COMPILER "$@"
