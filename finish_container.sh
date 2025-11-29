#!/bin/bash

set -u

print_help(){
	echo "usage: $0 podman/docker kill/nokill out_dir"
	echo "  docker/podman -- docker or podman container"
	echo "  kill/nokill -- how to finish: kill the container and then clean up / only clean up"
	echo "  out_dir -- build output directory used by this container (with container.id file)"
}

if [ $# -ne 3 ]; then
	echo "ERROR: Invalid amount of arguments specified"
	print_help
	exit 1
fi

RUNTIME="$1"
ACTION="$2"
OUT="$3"
SUDO_CMD=""
CID_FILE="$OUT/container.id"

if [ "$RUNTIME" != "podman" ] && [ $RUNTIME != "docker" ]; then
	echo "ERROR: Invalid conatiner engine specified"
	print_help
	exit 1
fi

RUNTIME_TEST_OUTPUT="$($RUNTIME ps 2>&1)"

if echo "$RUNTIME_TEST_OUTPUT" | grep -qi "permission denied"; then
	echo "Hey, we gonna use sudo for running the container"
	SUDO_CMD="sudo"
fi

if [ $ACTION != "kill" -a $ACTION != "nokill" ]; then
	echo "usage: $0 podman/docker kill/nokill out_dir"
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
