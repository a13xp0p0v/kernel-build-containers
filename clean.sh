#!/bin/sh

set -x

#sudo docker rm `sudo docker ps -a -q`
sudo docker rmi kernel-build-container:7
sudo docker rmi kernel-build-container:8
sudo docker ps -a
sudo docker images

