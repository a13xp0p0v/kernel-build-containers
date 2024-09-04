#!/bin/bash

MIN_GCC_VERSION=4
MAX_GCC_VERSION=14

MIN_CLANG_VERSION=12
MAX_CLANG_VERSION=17

build_gcc_container() {
	echo -e "\nBuilding a container with GCC_VERSION=$1 from UBUNTU_VERSION=$2"
	$SUDO_CMD docker build \
		--build-arg GCC_VERSION=$1 \
		--build-arg UBUNTU_VERSION=$2 \
		--build-arg UNAME=$(id -nu) \
		--build-arg UID=$(id -u) \
		--build-arg GID=$(id -g) \
		-t kernel-build-container:gcc-${GCC_VERSION} .
}

build_clang_container() {
	echo -e "\nBuilding a container with CLANG_VERSION=$1 and GCC_VERSION=$2 from UBUNTU_VERSION=$3"
	$SUDO_CMD docker build \
		--build-arg CLANG_VERSION=$1 \
		--build-arg GCC_VERSION=$2 \
		--build-arg UBUNTU_VERSION=$3 \
		--build-arg UNAME=$(id -nu) \
		--build-arg UID=$(id -u) \
		--build-arg GID=$(id -g) \
		-t kernel-build-container:clang-${CLANG_VERSION} .
}

build_gcc_4() {
	GCC_VERSION="4.9"
	UBUNTU_VERSION="16.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_5() {
	GCC_VERSION="5"
	UBUNTU_VERSION="16.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_6() {
	GCC_VERSION="6"
	UBUNTU_VERSION="18.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_7() {
	GCC_VERSION="7"
	UBUNTU_VERSION="18.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_8() {
	GCC_VERSION="8"
	UBUNTU_VERSION="20.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_9() {
	GCC_VERSION="9"
	UBUNTU_VERSION="20.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_10() {
	GCC_VERSION="10"
	UBUNTU_VERSION="20.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_11() {
	GCC_VERSION="11"
	UBUNTU_VERSION="22.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_12() {
	GCC_VERSION="12"
	UBUNTU_VERSION="22.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_13() {
	GCC_VERSION="13"
	UBUNTU_VERSION="23.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_gcc_14() {
	GCC_VERSION="14"
	UBUNTU_VERSION="24.04"
	build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_12() {
	CLANG_VERSION="12"
	GCC_VERSION="11"
	UBUNTU_VERSION="22.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_13() {
	CLANG_VERSION="13"
	GCC_VERSION="11"
	UBUNTU_VERSION="22.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_14() {
	CLANG_VERSION="14"
	GCC_VERSION="12"
	UBUNTU_VERSION="22.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_15() {
	CLANG_VERSION="15"
	GCC_VERSION="13"
	UBUNTU_VERSION="23.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_16() {
	CLANG_VERSION="16"
	GCC_VERSION="14"
	UBUNTU_VERSION="24.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_clang_17() {
	CLANG_VERSION="17"
	GCC_VERSION="14"
	UBUNTU_VERSION="24.04"
	build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}
}

build_all_containers() {
	build_gcc_4
	build_gcc_5
	build_gcc_6
	build_gcc_7
	build_gcc_8
	build_gcc_9
	build_gcc_10
	build_gcc_11
	build_gcc_12
	build_gcc_13
	build_gcc_14
	build_clang_12
	build_clang_13
	build_clang_14
	build_clang_15
	build_clang_16
	build_clang_17
}

# Help function to display usage information
show_help() {
	echo ""
	echo "Usage: $0 [compiler-version]"
	echo
	echo "Build containers for different compiler versions."
	echo
	echo "Arguments:"
	echo "  gcc-<version>   Set GCC_VERSION if <version> is between $MIN_GCC_VERSION and $MAX_GCC_VERSION."
	echo "  clang-<version> Set CLANG_VERSION if <version> is between $MIN_CLANG_VERSION and $MAX_CLANG_VERSION."
	echo
	echo "Examples:"
	echo "  $0 gcc-8       # Validates and sets GCC_VERSION to 8."
	echo "  $0 clang-15    # Validates and sets CLANG_VERSION to 15."
	echo "  $0             # No compiler version specified. Build all containers"
	echo
	echo "The script will exit with an error if the version is out of range or"
	echo "the format is incorrect."
}

# Check if the user has provided an argument
if [ $# -ne 1 ]; then
	echo "Building all gcc and clang version containers"
	build_all_containers
fi

# Extract the compiler and version from the argument
if [[ $1 =~ ^(gcc|clang)-([0-9]+)$ ]]; then
	COMPILER=${BASH_REMATCH[1]}
	VERSION=${BASH_REMATCH[2]}

    # Validate GCC versions
    if [ "$COMPILER" = "gcc" ] && [ "$VERSION" -ge 4 ] && [ "$VERSION" -le 14 ]; then
	    GCC_VERSION=$VERSION
	    echo "GCC_VERSION is set to: $GCC_VERSION"

    # Validate Clang versions
elif [ "$COMPILER" = "clang" ] && [ "$VERSION" -ge 14 ] && [ "$VERSION" -le 17 ]; then
	CLANG_VERSION=$VERSION
	echo "CLANG_VERSION is set to: $CLANG_VERSION"

else
	echo "Error: For gcc, version must be between 4 and 14; for clang, version must be between 14 and 17."
	show_help
	exit -1
    fi
else
	echo "Error: Invalid compiler version format. Valid formats are"
	echo "gcc-<version> (5 to 14) or clang-<version> (14 to 17)."
	show_help
	exit -1
fi

groups | grep docker
NEED_SUDO=$?

if [ $NEED_SUDO -eq 1 ]; then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

set -e

# Check and handle GCC_VERSION
if [ -n "$GCC_VERSION" ]; then
	build_gcc_$GCC_VERSION
else
	build_clang_$CLANG_VERSION
fi
