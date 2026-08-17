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
	echo -e "\nDone! We recommend to check \"docker/podman system df -v\" and use \"prune\" (be careful)"

	exit 0
fi

echo "Populate the Docker cache..."

python3 manage_images.py -d -b all
python3 manage_images.py -d -r all

echo "Populate the Podman cache..."

python3 manage_images.py -p -b all

# Now let's add tags to the intermediate image layers to make Podman preserve them.
# Otherwise Podman removes these layers when we run `python3 manage_images.py -p -r all`.
# Thanks to @Willenst for the idea.
for id in $(podman image ls -aq --filter "label=kernel-build-cache"); do
	podman tag "$id" "kernel-build-cache:$id"
done

python3 manage_images.py -p -r all

echo "Docker and Podman caches are populated. Go and run tests_for_manage_images.sh!"
echo -e "\nWARNING: the intermediate image layers in Podman occupy a lot of space."
echo "After finishing the tests, run \"$0 --clean\""
