#!/bin/sh

set -x
set -e

echo "Cleaning coverage cache"
coverage erase

echo "Testing help command..."
coverage run -a --branch manage_containers.py -h

echo "Testing adding..."
coverage run -a --branch manage_containers.py -a gcc-5
coverage run -a --branch manage_containers.py -a gcc-6

echo "Testing quiet adding..."
coverage run -a --branch manage_containers.py -a gcc-7 -q
coverage run -a --branch manage_containers.py -a gcc-8 -q

echo "Testing emoving..."
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -a gcc-4.9
coverage run -a --branch manage_containers.py -a gcc-5
coverage run -a --branch manage_containers.py -a gcc-6
coverage run -a --branch manage_containers.py -a gcc-7
coverage run -a --branch manage_containers.py -a gcc-8
coverage run -a --branch manage_containers.py -a gcc-9
coverage run -a --branch manage_containers.py -a gcc-10
coverage run -a --branch manage_containers.py -a gcc-11
coverage run -a --branch manage_containers.py -a gcc-12
coverage run -a --branch manage_containers.py -a gcc-13
coverage run -a --branch manage_containers.py -a gcc-14
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -a clang-7
coverage run -a --branch manage_containers.py -a clang-8
coverage run -a --branch manage_containers.py -a clang-9
coverage run -a --branch manage_containers.py -a clang-10
coverage run -a --branch manage_containers.py -a clang-11
coverage run -a --branch manage_containers.py -a clang-12
coverage run -a --branch manage_containers.py -a clang-13
coverage run -a --branch manage_containers.py -a clang-14
coverage run -a --branch manage_containers.py -a clang-15
coverage run -a --branch manage_containers.py -a clang-16
coverage run -a --branch manage_containers.py -a clang-17
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -a all
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -a all -q
coverage run -a --branch manage_containers.py -r all

echo "Testing list option..."
coverage run -a --branch manage_containers.py -a gcc-12
coverage run -a --branch manage_containers.py -l
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -l
coverage run -a --branch manage_containers.py -a all
coverage run -a --branch manage_containers.py -l
coverage run -a --branch manage_containers.py -r all
coverage run -a --branch manage_containers.py -l

echo "Testing removal with running containers..."
coverage run -a --branch manage_containers.py -a gcc-12
sudo docker run -d --rm --name test-running kernel-build-container:gcc-12 tail -f /dev/null
coverage run -a --branch manage_containers.py -r all
sudo docker stop test-running
coverage run -a --branch manage_containers.py -r all

echo "Collect coverage for error handling"

echo "Testing without options..."
coverage run -a --branch manage_containers.py && exit 1

echo "Testing list option with add and write..."
coverage run -a --branch manage_containers.py -a all -l && exit 1
coverage run -a --branch manage_containers.py -r all -l && exit 1
coverage run -a --branch manage_containers.py -a all -r all -l && exit 1
coverage run -a --branch manage_containers.py -a all -r all -l -q && exit 1

echo "Testing invalid arguments..."
coverage run -a --branch manage_containers.py -a non-existent-compiler && exit 1
coverage run -a --branch manage_containers.py -r invalid-option && exit 1

echo "Testing invalid combinations..."
coverage run -a --branch manage_containers.py -a gcc-10 -r all && exit 1
coverage run -a --branch manage_containers.py -a gcc-10 -r gcc-10 && exit 1
coverage run -a --branch manage_containers.py -r gcc-10 && exit 1 
coverage run -a --branch manage_containers.py -a all -r all && exit 1

echo "Testing adding existing container..."
coverage run -a --branch manage_containers.py -a gcc-10
coverage run -a --branch manage_containers.py -a gcc-10 && exit 1
coverage run -a --branch manage_containers.py -a gcc-12
coverage run -a --branch manage_containers.py -a clang-13 && exit 1
coverage run -a --branch manage_containers.py -r all

echo "Testing invalid GCC/Clang versions..."
coverage run -a --branch manage_containers.py -a gcc-invalid && exit 1 
coverage run -a --branch manage_containers.py -a clang-invalid && exit 1 

echo "Testing unknown options..."
coverage run -a --branch manage_containers.py --unknown-flag && exit 1 
coverage run -a --branch manage_containers.py -a gcc-4.9 --unknown-flag && exit 1 

echo "All tests completed. Creating report"
coverage report --omit='/usr/lib/python3/dist-packages/*'
coverage html --omit='/usr/lib/python3/dist-packages/*'
rm .coverage