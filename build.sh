#!/bin/sh

set -x
set -e

#GCC_VERSION=8
#UBUNTU_VERSION=19

GCC_VERSION=7
UBUNTU_VERSION=18

sudo docker build \
 --build-arg GCC_VERSION=${GCC_VERSION} \
 --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
 --build-arg UNAME=$(id -nu) \
 --build-arg UID=$(id -u) \
 --build-arg GID=$(id -g)  \
 -t kernel-build-container:${GCC_VERSION} .
