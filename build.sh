#!/bin/sh

set -x
set -e

build ()
{
 sudo docker build \
  --build-arg GCC_VERSION=$1 \
  --build-arg UBUNTU_VERSION=$2 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:${GCC_VERSION} .
 echo -e "\n"
}

GCC_VERSION="4.8"
UBUNTU_VERSION="16.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="5"
UBUNTU_VERSION="16.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="6"
UBUNTU_VERSION="18.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="7"
UBUNTU_VERSION="18.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="8"
UBUNTU_VERSION="20.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="9"
UBUNTU_VERSION="20.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

GCC_VERSION="10"
UBUNTU_VERSION="20.04"
build ${GCC_VERSION} ${UBUNTU_VERSION}

