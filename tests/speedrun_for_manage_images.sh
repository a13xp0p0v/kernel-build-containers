#!/bin/bash

# This script provides speedrun for `tests_for_manage_images.sh`:
# it populates the Docker and Podman caches, which makes `manage_images.py` faster.

set -eu

# Go to the root directory of the project
cd "$(dirname "$(dirname "$(readlink -fm "$0")")")"

print_help() {
	echo "usage:"
	echo "  $0          populate Docker and Podman caches (speedrun for tests_for_manage_images.sh)"
	echo "  $0 --clean  remove Docker and Podman artifacts associated with kernel-build-containers"
}

if [ $# -gt 1 ]; then
	print_help
	exit 1
fi

if [ $# -eq 1 ]; then
	if [ "$1" != "--clean" ]; then
		print_help
		exit 1
	fi

	echo -e "Remove Docker and Podman artifacts associated with kernel-build-containers:\n"
	python3 manage_images.py -d -r all
	python3 manage_images.py -p -r all
	podman image prune --all --force --filter "label=kernel-build-cache"
	echo -e "\nDone! We recommend you to check \"docker/podman system df -v\""

	exit 0
fi

REQUIRED_SPACE_GiB=100 # Approximate size of all kernel-build-containers artifacts
REQUIRED_SPACE_KiB=$((REQUIRED_SPACE_GiB * 1024 * 1024))
PODMAN_STORAGE_PATH=$(podman info --format '{{.Store.GraphRoot}}')
AVAILABLE_SPACE_KiB=$(df -Pk "$PODMAN_STORAGE_PATH" | awk 'NR==2 {print $4}')
AVAILABLE_SPACE_GiB=$((AVAILABLE_SPACE_KiB / 1024 / 1024))

if [ "$REQUIRED_SPACE_KiB" -gt "$AVAILABLE_SPACE_KiB" ]; then
	echo "Not enough space at the FS containing $PODMAN_STORAGE_PATH"
	echo "$0 needs at least $REQUIRED_SPACE_GiB GiB (but we have only $AVAILABLE_SPACE_GiB GiB)"
	exit 1
fi

echo "Warming Docker cache..."
python3 manage_images.py -d -b all
python3 manage_images.py -d -r all

echo "Warming Podman cache..."

python3 manage_images.py -p -b all

for id in $(podman image ls -aq \
    --filter "label=kernel-build-cache"); do
    podman tag "$id" "kernel-build-cache:$id"
done

python3 manage_images.py -p -r all


echo "Cache baked."
echo
echo "WARNING: the warmed Podman caches can use substantial disk space."
echo "To remove the cache layers created by this script, run:"
echo "  $0 --clean"
