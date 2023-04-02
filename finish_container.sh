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

if [ $# -ne 2 ]
then
	echo "usage: $0 kill/nokill out_dir"
	echo "  kill/nokill -- how to finish: kill the container and then clean up / only clean up"
	echo "  out_dir -- build output directory used by this container (with container.id file)"
	exit 1
fi

ACTION="$1"
OUT="$2"
CID_FILE="$OUT/container.id"

if [ $ACTION != "kill" -a $ACTION != "nokill" ]
then
	echo "You have to choose: kill or nokill"
	echo "usage: $0 kill/nokill out_dir"
	exit 1
fi

echo "Search \"container.id\" file in build output directory \"$OUT\""
if [ ! -f $CID_FILE ]
then
	echo "NO such file, nothing to do, exit"
	exit 2
fi

echo "OK, \"container.id\" file exists, removing it"
ID=`awk 'NR==1 {print $1}' $CID_FILE`
$SUDO_CMD rm -f $CID_FILE

if [ $ACTION = "kill" ]
then
	echo "Killing the docker container $ID"
	$SUDO_CMD docker kill "$ID"
	if [ $? -ne 0 ]
	then
		echo "Something goes wrong, failed to kill container $ID"
		exit 3
	fi
	echo "Container $ID is killed"
else
	STATUS=`$SUDO_CMD docker container inspect -f '{{.State.Status}}' "$ID" 2>&1`
	if [ "$STATUS" = "running" ]
	then
		echo "Something goes wrong, container $ID is running!"
		exit 4
	fi
	echo "OK, container $ID doesn't run"
fi
