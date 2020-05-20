#!/bin/bash

set -x

#sudo docker rm `sudo docker ps -a -q`
sudo docker rmi kernel-build-container:gcc-4.8
sudo docker rmi kernel-build-container:gcc-5
sudo docker rmi kernel-build-container:gcc-6
sudo docker rmi kernel-build-container:gcc-7
sudo docker rmi kernel-build-container:gcc-8
sudo docker rmi kernel-build-container:gcc-9
sudo docker rmi kernel-build-container:gcc-10
sudo docker ps -a
sudo docker image ls
