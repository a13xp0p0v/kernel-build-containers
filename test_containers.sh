#!/bin/sh

set -x
set -e

if groups $USER | grep '\<docker\>'; then
    echo "The user running this test is in the docker group"
else
    echo "The user running this test is NOT in the docker group (will need sudo)"
fi

echo "Clearing the state before the test..."
python3 manage_containers.py -r
python3 -m coverage erase

echo "Testing the help flag..."
python3 -m coverage run -a --branch manage_containers.py -h

echo "Testing building..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-5
python3 -m coverage run -a --branch manage_containers.py -b gcc-6

echo "Testing quiet building..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-7 -q
python3 -m coverage run -a --branch manage_containers.py -b gcc-8 -q

echo "Testing removal..."
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -b gcc-4.9
python3 -m coverage run -a --branch manage_containers.py -b gcc-5
python3 -m coverage run -a --branch manage_containers.py -b gcc-6
python3 -m coverage run -a --branch manage_containers.py -b gcc-7
python3 -m coverage run -a --branch manage_containers.py -b gcc-8
python3 -m coverage run -a --branch manage_containers.py -b gcc-9
python3 -m coverage run -a --branch manage_containers.py -b gcc-10
python3 -m coverage run -a --branch manage_containers.py -b gcc-11
python3 -m coverage run -a --branch manage_containers.py -b gcc-12
python3 -m coverage run -a --branch manage_containers.py -b gcc-13
python3 -m coverage run -a --branch manage_containers.py -b gcc-14
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -b clang-7
python3 -m coverage run -a --branch manage_containers.py -b clang-8
python3 -m coverage run -a --branch manage_containers.py -b clang-9
python3 -m coverage run -a --branch manage_containers.py -b clang-10
python3 -m coverage run -a --branch manage_containers.py -b clang-11
python3 -m coverage run -a --branch manage_containers.py -b clang-12
python3 -m coverage run -a --branch manage_containers.py -b clang-13
python3 -m coverage run -a --branch manage_containers.py -b clang-14
python3 -m coverage run -a --branch manage_containers.py -b clang-15
python3 -m coverage run -a --branch manage_containers.py -b clang-16
python3 -m coverage run -a --branch manage_containers.py -b clang-17
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -b all
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -b all -q
python3 -m coverage run -a --branch manage_containers.py -r

echo "Testing the list option..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-12
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -b all
python3 -m coverage run -a --branch manage_containers.py -l
python3 -m coverage run -a --branch manage_containers.py -r
python3 -m coverage run -a --branch manage_containers.py -l

echo "Testing removal when containers are running..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-12
if groups $USER | grep '\<docker\>'; then
    docker run -d --rm --name test-running kernel-build-container:gcc-12 tail -f /dev/null
    python3 -m coverage run -a --branch manage_containers.py -r
    docker stop test-running
else
    sudo docker run -d --rm --name test-running kernel-build-container:gcc-12 tail -f /dev/null
    python3 -m coverage run -a --branch manage_containers.py -r
    sudo docker stop test-running
fi
python3 -m coverage run -a --branch manage_containers.py -r

echo "Testing building an existing image..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-10
python3 -m coverage run -a --branch manage_containers.py -b gcc-10
python3 -m coverage run -a --branch manage_containers.py -b gcc-12
python3 -m coverage run -a --branch manage_containers.py -b clang-13 #it's the same container as gcc-12
python3 -m coverage run -a --branch manage_containers.py -b all
python3 -m coverage run -a --branch manage_containers.py -r

echo "Testing the error handling..."

echo "Testing without any options..."
python3 -m coverage run -a --branch manage_containers.py && exit 1

echo "Testing invalid arguments..."
python3 -m coverage run -a --branch manage_containers.py -b non-existent-compiler && exit 1
python3 -m coverage run -a --branch manage_containers.py -r invalid-option && exit 1

echo "Testing invalid combinations..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-10 -r && exit 1
python3 -m coverage run -a --branch manage_containers.py -b gcc-10 -r gcc-10 && exit 1
python3 -m coverage run -a --branch manage_containers.py -r gcc-10 && exit 1
python3 -m coverage run -a --branch manage_containers.py -r all && exit 1
python3 -m coverage run -a --branch manage_containers.py -b all -r && exit 1
python3 -m coverage run -a --branch manage_containers.py -b all -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -r all -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -b all -r -l && exit 1
python3 -m coverage run -a --branch manage_containers.py -b all -r -l -q && exit 1

echo "Testing invalid GCC/Clang version..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-invalid && exit 1
python3 -m coverage run -a --branch manage_containers.py -b clang-invalid && exit 1

echo "Testing unknown options..."
python3 -m coverage run -a --branch manage_containers.py --unknown-flag && exit 1
python3 -m coverage run -a --branch manage_containers.py -b gcc-4.9 --unknown-flag && exit 1

echo "Testing containers with missing GCC tags..."
python3 -m coverage run -a --branch manage_containers.py -b gcc-12
if groups $USER | grep '\<docker\>'; then
    docker rmi -f kernel-build-container:gcc-12
    python3 -m coverage run -a --branch manage_containers.py -l && exit 1
    docker rmi -f kernel-build-container:clang-13
else
    sudo docker rmi -f kernel-build-container:gcc-12
    python3 -m coverage run -a --branch manage_containers.py -l && exit 1
    sudo docker rmi -f kernel-build-container:clang-13
fi

echo "All tests completed. Creating the coverage report..."
python3 -m coverage report --omit='/usr/lib/python3/dist-packages/*'
python3 -m coverage html --omit='/usr/lib/python3/dist-packages/*'
