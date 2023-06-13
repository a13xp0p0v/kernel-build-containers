#!/bin/bash

source ./config.sh

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

remove_image() {
	COMPILER=$1
	# stop and remove container if it exists
	$SUDO_CMD docker ps -a | grep kernel-build-container:$COMPILER > /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		CONTAINER_ID=$($SUDO_CMD docker ps -a | grep kernel-build-container:$COMPILER | awk '{print $1}')
		echo "Stopping container $CONTAINER_ID"
		$SUDO_CMD docker stop $CONTAINER_ID
		echo "Removing container $CONTAINER_ID"
		$SUDO_CMD docker rm $CONTAINER_ID > /dev/null 2>&1
	fi
	# remove image
	$SUDO_CMD docker image inspect kernel-build-container:$COMPILER > /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo "Removing image kernel-build-container:$COMPILER"
		$SUDO_CMD docker rmi kernel-build-container:$COMPILER
	fi
}

for v in "${GCC_SUPPORTED_VERSIONS[@]}"
do
	COMPILER="gcc-$v"
	remove_image $COMPILER
done

for v in "${CLANG_SUPPORTED_VERSIONS[@]}"
do
	COMPILER="clang-$v"
	remove_image $COMPILER
done

$SUDO_CMD docker ps -a
$SUDO_CMD docker image ls
