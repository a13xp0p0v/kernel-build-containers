#!/bin/bash
# This is a speedrun booster for manage_images.py: it pre-populates Docker
# and Podman build caches to make tests_for_manage_images.sh much faster.
#
# Idea:
#
# The normal image manager removes final images with `rmi`. For Podman this
# would remove untagged intermediate layers, so subsequent builds lose their
# local layer cache. The image manager labels intermediate Podman layers during
# the build. This script adds tags to those layers before removing the final
# images, leaving only the reusable cache layers.
#
# Docker keeps its builder cache independently, so its part simply builds all
# images once and removes the final images afterwards.

set -e

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
