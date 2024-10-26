#!/bin/sh

set -x
set -e

echo "Tests must be run with and without the docker group"

if groups $USER | grep -q 'docker'; then
    echo "Running tests with the docker group"
else
    echo "Running tests without the docker group"
fi

sleep 3 #sleep to notice the current group

echo "Clearing coverage cache"
python3 -m coverage erase

echo "Testing the help flag..."
python3 -m coverage run -a --branch manage_containers.py -h

echo "Testing addition..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-5
python3 -m coverage run -a --branch manage_containers.py -a gcc-6

echo "Testing quiet addition..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-7 -q
python3 -m coverage run -a --branch manage_containers.py -a gcc-8 -q

echo "Testing removal..."
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -a gcc-4.9
python3 -m coverage run -a --branch manage_containers.py -a gcc-5
python3 -m coverage run -a --branch manage_containers.py -a gcc-6
python3 -m coverage run -a --branch manage_containers.py -a gcc-7
python3 -m coverage run -a --branch manage_containers.py -a gcc-8
python3 -m coverage run -a --branch manage_containers.py -a gcc-9
python3 -m coverage run -a --branch manage_containers.py -a gcc-10
python3 -m coverage run -a --branch manage_containers.py -a gcc-11
python3 -m coverage run -a --branch manage_containers.py -a gcc-12
python3 -m coverage run -a --branch manage_containers.py -a gcc-13
python3 -m coverage run -a --branch manage_containers.py -a gcc-14
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -a clang-7
python3 -m coverage run -a --branch manage_containers.py -a clang-8
python3 -m coverage run -a --branch manage_containers.py -a clang-9
python3 -m coverage run -a --branch manage_containers.py -a clang-10
python3 -m coverage run -a --branch manage_containers.py -a clang-11
python3 -m coverage run -a --branch manage_containers.py -a clang-12
python3 -m coverage run -a --branch manage_containers.py -a clang-13
python3 -m coverage run -a --branch manage_containers.py -a clang-14
python3 -m coverage run -a --branch manage_containers.py -a clang-15
python3 -m coverage run -a --branch manage_containers.py -a clang-16
python3 -m coverage run -a --branch manage_containers.py -a clang-17
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -a all
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -a all -q
python3 -m coverage run -a --branch manage_containers.py -r

echo "Testing the list option..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-12
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -a all
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -l

echo "Testing removal with running containers..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-12
if groups $USER | grep 'docker'; then
    docker run -d --rm --name test-running kernel-build-container:gcc-12 tail -f /dev/null
    python3 -m coverage run -a --branch manage_containers.py -r
    docker stop test-running
else
    sudo docker run -d --rm --name test-running kernel-build-container:gcc-12 tail -f /dev/null
    python3 -m coverage run -a --branch manage_containers.py -r
    sudo docker stop test-running
fi
python3 -m coverage run -a --branch manage_containers.py -r

echo "Collecting coverage for error handling"

echo "Testing without any options..."
python3 -m coverage run -a --branch manage_containers.py && exit 1

echo "Testing invalid arguments..."
python3 -m coverage run -a --branch manage_containers.py -a non-existent-compiler && exit 1
python3 -m coverage run -a --branch manage_containers.py -r invalid-option && exit 1

echo "Testing invalid combinations..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-10 -r && exit 1
python3 -m coverage run -a --branch manage_containers.py -a gcc-10 -r gcc-10 && exit 1
python3 -m coverage run -a --branch manage_containers.py -r gcc-10 && exit 1
python3 -m coverage run -a --branch manage_containers.py -r all && exit 1
python3 -m coverage run -a --branch manage_containers.py -a all -r && exit 1
python3 -m coverage run -a --branch manage_containers.py -a all -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -r all -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -a all -r -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -a all -r -l -q && exit 1

echo "Testing adding an existing container..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-10
python3 -m coverage run -a --branch manage_containers.py -a gcc-10 && exit 1
python3 -m coverage run -a --branch manage_containers.py -a gcc-12
python3 -m coverage run -a --branch manage_containers.py -a clang-13 && exit 1 #it's the same container as gcc-12
python3 -m coverage run -a --branch manage_containers.py -a all
python3 -m coverage run -a --branch manage_containers.py -r

echo "Testing invalid GCC/Clang version..."
python3 -m coverage run -a --branch manage_containers.py -a gcc-invalid && exit 1 
python3 -m coverage run -a --branch manage_containers.py -a clang-invalid && exit 1 

echo "Testing unknown options..."
python3 -m coverage run -a --branch manage_containers.py --unknown-flag && exit 1 
python3 -m coverage run -a --branch manage_containers.py -a gcc-4.9 --unknown-flag && exit 1 

echo "All tests completed. Creating report"
python3 -m coverage report --omit='/usr/lib/python3/dist-packages/*'
python3 -m coverage html --omit='/usr/lib/python3/dist-packages/*'
rm .coverage
