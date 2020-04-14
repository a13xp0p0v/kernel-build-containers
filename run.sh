#!/bin/sh

if [ $# != 1 ];
then
	echo "usage: $0 gcc_version"
	exit 1
fi

# Z for setting SELinux label
sudo docker run --rm -v /home/a13x/Develop_local/linux:/home/$(id -nu)/src:Z -it kernel-build-container:$1
