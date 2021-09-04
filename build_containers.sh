#!/bin/bash

groups | grep docker
NEED_SUDO=$?

if [ $NEED_SUDO -eq 1 ]
then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

set -e

build_gcc_container ()
{
 echo -e "\nBuilding a container with GCC_VERSION=$1 from UBUNTU_VERSION=$2"
 $SUDO_CMD docker build \
  --build-arg GCC_VERSION=$1 \
  --build-arg UBUNTU_VERSION=$2 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:gcc-${GCC_VERSION} .
}

GCC_VERSION="4.8"
UBUNTU_VERSION="16.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="5"
UBUNTU_VERSION="16.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="6"
UBUNTU_VERSION="18.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="7"
UBUNTU_VERSION="18.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="8"
UBUNTU_VERSION="20.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="9"
UBUNTU_VERSION="20.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="10"
UBUNTU_VERSION="20.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="11"
UBUNTU_VERSION="21.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}

build_clang_container ()
{
 echo -e "\nBuilding a container with CLANG_VERSION=$1 and GCC_VERSION=$2 from UBUNTU_VERSION=$3"
 $SUDO_CMD docker build \
  --build-arg CLANG_VERSION=$1 \
  --build-arg GCC_VERSION=$2 \
  --build-arg UBUNTU_VERSION=$3 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:clang-${CLANG_VERSION} .
}

CLANG_VERSION="12"
GCC_VERSION="10"
UBUNTU_VERSION="21.04"
build_clang_container ${CLANG_VERSION} ${GCC_VERSION} ${UBUNTU_VERSION}

