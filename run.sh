#!/bin/sh

set -x
set -e

#GCC_VERSION=8
GCC_VERSION=7

# Z for setting SELinux label
sudo docker run -v /home/a13x/Develop_local/linux:/home/$(id -nu)/src:Z -it kernel-build-container:${GCC_VERSION}
