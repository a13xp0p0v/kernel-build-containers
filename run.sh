#!/bin/sh

if [ $# != 2 ];
then
	echo "usage: $0 gcc_version src_dir"
	exit 1
fi

# Z for setting SELinux label
sudo docker run --rm -v $2:/home/$(id -nu)/src:Z -it kernel-build-container:$1
