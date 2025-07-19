#!/bin/bash

if [ $# -ne 3 ]; then
	echo "usage: $0 kill/nokill out_dir podman/docker"
	echo "  kill/nokill -- how to finish: kill the container and then clean up / only clean up"
	echo "  out_dir -- build output directory used by this container (with container.id file)"
	echo "  docker/podman -- docker or podman image runtime"
	exit 1
fi

ACTION="$1"
OUT="$2"
RUNTIME="$3"
SUDO_CMD=""
CID_FILE="$OUT/container.id"

output=$($RUNTIME ps 2>&1)
set -eu

if [ "$RUNTIME" = "podman" ]; then
	if [ "$EUID" -eq 0 ]; then
		echo "Dont use podman with sudo, it's rootless!" >&2
		exit 1
	fi
	echo "Hey, you are running podman as $USERNAME ($(id -u))"
elif [ "$RUNTIME" = "docker" ]; then
	if echo "$output" | grep -qi "CONTAINER ID"; then
		echo "Enough permissions to run docker, sudo is not needed"
	elif echo "$output" | grep -qi "permission denied"; then
		echo "Hey, we gonna use sudo for running docker"
		SUDO_CMD="sudo"
	fi
else
	echo "unexpected state or image runtime engine" >&2
	echo "usage: $0 kill/nokill out_dir podman/docker podman/docker"
	echo "  kill/nokill -- how to finish: kill the container and then clean up / only clean up"
	echo "  out_dir -- build output directory used by this container (with container.id file)"
	echo "  docker/podman -- docker or podman image runtime"
	exit 1
fi

if [ $ACTION != "kill" -a $ACTION != "nokill" ]; then
	echo "You have to choose: kill or nokill"
	echo "usage: $0 kill/nokill out_dir podman/docker"
	exit 1
fi

echo "Search \"container.id\" file in build output directory \"$OUT\""
if [ ! -f $CID_FILE ]; then
	echo "NO such file, nothing to do, exit"
	exit 2
fi

echo "OK, \"container.id\" file exists, removing it"
ID=$(awk 'NR==1 {print $1}' $CID_FILE)
$SUDO_CMD rm -f $CID_FILE

if [ $ACTION = "kill" ]; then
	echo "Killing the $RUNTIME container $ID"
	$SUDO_CMD $RUNTIME kill "$ID"
	if [ $? -ne 0 ]; then
		echo "Something goes wrong, failed to kill container $ID"
		exit 3
	fi
	echo "Container $ID is killed"
else
	STATUS=$($SUDO_CMD $RUNTIME container inspect -f '{{.State.Status}}' "$ID" 2>&1)
	if [ "$STATUS" = "running" ]; then
		echo "Something goes wrong, container $ID is running!"
		exit 4
	fi
	echo "OK, container $ID doesn't run"
fi
