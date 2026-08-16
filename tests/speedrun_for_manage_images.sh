#!/bin/bash

# This script provides speedrun for `tests_for_manage_images.sh`:
# it populates the Docker and Podman caches, which makes `manage_images.py` faster.

set -eu

# Go to the root directory of the project
cd "$(dirname "$(dirname "$(readlink -fm "$0")")")"

MIN_SPACE_GB=100    # Approximate size of all containers combined
clean=false

usage() {
    echo "Usage: $0 [--clean]"
    echo
    echo "  --clean  remove Podman cache layers"
}

for arg in "$@"; do
    case "$arg" in
        --clean) clean=true ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

if $clean; then
    echo "Removing Podman cache..."

    podman image prune \
        --all \
        --force \
        --filter "label=kernel-build-cache"

    exit 0
fi

# Existing images could be left without layers, ask to remove them first
if [[ -n $(podman images -q kernel-build-container) ]]; then
    echo "Podman already has kernel-build-container images"
    echo "Remove them with: python3 manage_images.py -p -r all"
    exit 1
fi

required_kb=$((MIN_SPACE_GB * 1024 * 1024))

for storage in / "$HOME"; do
    free_kb=$(df -Pk "$storage" | awk 'END { print $4 }')
    free_gb=$((free_kb / 1024 / 1024))

    if ((free_kb < required_kb)); then
        echo "ERROR!"
        echo "Insufficient free space on the filesystem containing '$storage' directory"
        echo "Available: ${free_gb} GiB; required: $MIN_SPACE_GB GiB"
        echo "Cache warmup will not be started!"
        exit 1
    fi
done

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
