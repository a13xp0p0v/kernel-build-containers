#!/bin/sh

set -eu

DELIMITER="echo -e \n##############################################"
RUNTIME_FLAG=""
RUNTIME=""
SUDO_CMD=""

check_if_sudo_needed() {
	set +e
	RUNTIME_TEST_OUTPUT="$($RUNTIME ps 2>&1)"
	set -e
	if echo "$RUNTIME_TEST_OUTPUT" | grep -qi "permission denied"; then
		echo "Hey, we gonna use sudo for running the container"
		SUDO_CMD="sudo"
	else
		SUDO_CMD=""
	fi
}

clear_state() {
	$DELIMITER
	echo "Clearing the state before the test..."
	python3 manage_images.py -r $RUNTIME_FLAG
}

run_basic_tests() {
	$DELIMITER
	echo "Testing help message printing..."
	python3 -m coverage run -a --branch manage_images.py -h

	$DELIMITER
	echo "Testing image building..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-8 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-11 $RUNTIME_FLAG

	$DELIMITER
	echo "Testing quiet image building..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 -q $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-15 -q $RUNTIME_FLAG

	$DELIMITER
	echo "Testing image listing..."
	python3 -m coverage run -a --branch manage_images.py -l $RUNTIME_FLAG

	$DELIMITER
	echo "Testing image removal..."
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r clang-11 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $RUNTIME_FLAG

	$DELIMITER
	echo "Testing building and removing all images..."
	python3 -m coverage run -a --branch manage_images.py -b $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -b all $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r all $RUNTIME_FLAG

	$DELIMITER
	echo "Testing building an existing image..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-6 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-7 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $RUNTIME_FLAG

	$DELIMITER
	echo "Testing removing a non-existing image..."
	python3 -m coverage run -a --branch manage_images.py -r gcc-13 $RUNTIME_FLAG

	$DELIMITER
	echo "Testing image removal when containers are running..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 $RUNTIME_FLAG
	$SUDO_CMD $RUNTIME run -d --rm --name test-running-1 kernel-build-container:gcc-12 tail -f /dev/null
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r clang-13 $RUNTIME_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $RUNTIME_FLAG
	$SUDO_CMD $RUNTIME stop test-running-1
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $RUNTIME_FLAG
}

run_error_handling_tests() {
	$DELIMITER
	echo "Testing the error handling..."

	$DELIMITER
	echo "Testing without any options..."
	python3 -m coverage run -a --branch manage_images.py && exit 1

	$DELIMITER
	echo "Testing invalid arguments..."
	python3 -m coverage run -a --branch manage_images.py -b strange-compiler $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -r strange-compiler $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -strange-option $RUNTIME_FLAG && exit 1

	$DELIMITER
	echo "Testing some invalid combinations..."
	python3 -m coverage run -a --branch manage_images.py -l -d -p && exit 1
	python3 -m coverage run -a --branch manage_images.py -q $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -q -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -q -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -q -l $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -q -l -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -q -l -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -l -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -l -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -r gcc-12 -q $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b -l $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -q $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b -l -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b -l -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r gcc-12 $RUNTIME_FLAG && exit 1
	python3 -m coverage run -a --branch manage_images.py -b gcc-10 -l -r gcc-12 -q $RUNTIME_FLAG && exit 1

	$DELIMITER
	echo "Testing containers with missing GCC tags..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 $RUNTIME_FLAG
	$SUDO_CMD $RUNTIME rmi -f kernel-build-container:gcc-12
	python3 -m coverage run -a --branch manage_images.py -l $RUNTIME_FLAG && exit 1
	$SUDO_CMD $RUNTIME rmi -f kernel-build-container:clang-13
	python3 -m coverage run -a --branch manage_images.py -l $RUNTIME_FLAG

	$DELIMITER
	echo "Emulating that the container runtime is not installed..."
	PATH="" /usr/bin/python3 -m coverage run -a --branch manage_images.py -l $RUNTIME_FLAG && exit 1

	$DELIMITER
	echo "Emulating an unknown error from the container runtime..."
	# Use /usr/bin/ls as a fake container runtime to make the `$RUNTIME ps` command
	# in manage_images.py return an error "cannot access 'ps': No such file or directory" :)
	if [ -f ps ]; then
		echo "Can't finish the test, please remove the ./ps file"
		exit 1
	fi
	cp /usr/bin/ls /tmp/$RUNTIME
	PATH="/tmp" /usr/bin/python3 -m coverage run -a --branch manage_images.py -l $RUNTIME_FLAG && exit 1
	rm /tmp/$RUNTIME
}

test_with_stopped_docker_service() {
	$DELIMITER
	echo "Test the tool with disabled Docker service"
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.service
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.socket
	$SUDO_CMD systemctl stop docker.service
	$SUDO_CMD systemctl stop docker.socket
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.service && exit 1
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.socket && exit 1
	python3 -m coverage run -a --branch manage_images.py -l -d && exit 1
	$SUDO_CMD systemctl start docker.service
	$SUDO_CMD systemctl start docker.socket
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.service
	$SUDO_CMD systemctl --no-pager status --lines=0 docker.socket
}

run_tests() {
	check_if_sudo_needed
	clear_state
	run_basic_tests
	run_error_handling_tests
}

echo "Let's test manage_images.py..."
python3 -m coverage erase

# Test Docker as a default container runtime (without a flag)
RUNTIME="docker"
RUNTIME_FLAG=""
run_tests

test_with_stopped_docker_service

# Test Docker
RUNTIME="docker"
RUNTIME_FLAG="-d"
run_tests

# Test Podman
RUNTIME="podman"
RUNTIME_FLAG="-p"
run_tests

$DELIMITER
echo "All tests completed. Creating the coverage report..."
python3 -m coverage report
python3 -m coverage html
echo "Well done!"
