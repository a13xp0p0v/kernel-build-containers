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

set -x

#$SUDO_CMD docker rm `sudo docker ps -a -q`
$SUDO_CMD docker rmi kernel-build-container:gcc-4.9
$SUDO_CMD docker rmi kernel-build-container:gcc-5
$SUDO_CMD docker rmi kernel-build-container:gcc-6
$SUDO_CMD docker rmi kernel-build-container:gcc-7
$SUDO_CMD docker rmi kernel-build-container:gcc-8
$SUDO_CMD docker rmi kernel-build-container:gcc-9
$SUDO_CMD docker rmi kernel-build-container:gcc-10
$SUDO_CMD docker rmi kernel-build-container:gcc-11
$SUDO_CMD docker rmi kernel-build-container:gcc-12
$SUDO_CMD docker rmi kernel-build-container:clang-12
$SUDO_CMD docker rmi kernel-build-container:clang-13
$SUDO_CMD docker rmi kernel-build-container:clang-14
$SUDO_CMD docker rmi kernel-build-container:clang-15
$SUDO_CMD docker ps -a
$SUDO_CMD docker image ls
