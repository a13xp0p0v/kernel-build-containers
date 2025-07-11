#!/bin/sh

DELIMITER="echo -e \n##############################################"

groups | grep '\<docker\>' > /dev/null
NEED_SUDO=$?

if [ $NEED_SUDO -eq 1 ]; then
	echo "The user running this test is NOT in the docker group (will need sudo)"
	SUDO_CMD="sudo"
else
	echo "The user running this test is in the docker group"
	SUDO_CMD=""
fi

set -eux

$DELIMITER
echo "Clearing the state before the test..."
python3 manage_images.py -r
python3 -m coverage erase

$DELIMITER
echo "Testing help message printing..."
python3 -m coverage run -a --branch manage_images.py -h

$DELIMITER
echo "Testing image building..."
python3 -m coverage run -a --branch manage_images.py -b gcc-8
python3 -m coverage run -a --branch manage_images.py -b clang-11

$DELIMITER
echo "Testing quiet image building..."
python3 -m coverage run -a --branch manage_images.py -b gcc-12 -q
python3 -m coverage run -a --branch manage_images.py -b clang-15 -q

$DELIMITER
echo "Testing image listing..."
python3 -m coverage run -a --branch manage_images.py -l

$DELIMITER
echo "Testing image removal..."
python3 -m coverage run -a --branch manage_images.py -r gcc-12
python3 -m coverage run -a --branch manage_images.py -r clang-11
python3 -m coverage run -a --branch manage_images.py -r

$DELIMITER
echo "Testing building and removing all images..."
python3 -m coverage run -a --branch manage_images.py -b
python3 -m coverage run -a --branch manage_images.py -r
python3 -m coverage run -a --branch manage_images.py -b all
python3 -m coverage run -a --branch manage_images.py -r all

$DELIMITER
echo "Testing building an existing image..."
python3 -m coverage run -a --branch manage_images.py -b gcc-6
python3 -m coverage run -a --branch manage_images.py -b clang-7
python3 -m coverage run -a --branch manage_images.py -r

$DELIMITER
echo "Testing removing a non-existing image..."
python3 -m coverage run -a --branch manage_images.py -r gcc-13

$DELIMITER
echo "Testing image removal when containers are running..."
python3 -m coverage run -a --branch manage_images.py -b gcc-12
$SUDO_CMD docker run -d --rm --name test-running-1 kernel-build-container:gcc-12 tail -f /dev/null
python3 -m coverage run -a --branch manage_images.py -r gcc-12
python3 -m coverage run -a --branch manage_images.py -r clang-13
python3 -m coverage run -a --branch manage_images.py -r
$SUDO_CMD docker stop test-running-1
python3 -m coverage run -a --branch manage_images.py -r gcc-12

$DELIMITER
echo "Testing the error handling..."

$DELIMITER
echo "Testing without any options..."
python3 -m coverage run -a --branch manage_images.py && exit 1

$DELIMITER
echo "Testing invalid arguments..."
python3 -m coverage run -a --branch manage_images.py -b strange-compiler && exit 1
python3 -m coverage run -a --branch manage_images.py -r strange-compiler && exit 1
python3 -m coverage run -a --branch manage_images.py -strange-option && exit 1

$DELIMITER
echo "Testing some invalid combinations..."
python3 -m coverage run -a --branch manage_images.py -q && exit 1
python3 -m coverage run -a --branch manage_images.py -q -r && exit 1
python3 -m coverage run -a --branch manage_images.py -q -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -q -l && exit 1
python3 -m coverage run -a --branch manage_images.py -q -l -r && exit 1
python3 -m coverage run -a --branch manage_images.py -q -l -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -l -r && exit 1
python3 -m coverage run -a --branch manage_images.py -l -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -b -r && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r && exit 1
python3 -m coverage run -a --branch manage_images.py -b -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r gcc-12 -q && exit 1
python3 -m coverage run -a --branch manage_images.py -b -l && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -q && exit 1
python3 -m coverage run -a --branch manage_images.py -b -l -r && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r && exit 1
python3 -m coverage run -a --branch manage_images.py -b -l -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r gcc-12 && exit 1
python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r gcc-12 -q && exit 1

$DELIMITER
echo "Testing containers with missing GCC tags..."
python3 -m coverage run -a --branch manage_images.py -b gcc-12
$SUDO_CMD docker rmi -f kernel-build-container:gcc-12
python3 -m coverage run -a --branch manage_images.py -l && exit 1
$SUDO_CMD docker rmi -f kernel-build-container:clang-13
python3 -m coverage run -a --branch manage_images.py -l

$DELIMITER
echo "All tests completed. Creating the coverage report..."
python3 -m coverage report
python3 -m coverage html

echo "Well done!"
