#!/bin/sh

DELIMITER="echo -e \n##############################################"
ENGINE_FLAG=""
ENGINE=""
SUDO_CMD=""

set -eux

check_sudo(){
	set +e
	RUNTIME_TEST_OUTPUT="$($ENGINE ps 2>&1)"
	set -e
	if echo "$RUNTIME_TEST_OUTPUT" | grep -qi "permission denied"; then
		echo "Hey, we gonna use sudo for running the container"
		SUDO_CMD="sudo"
	else
		SUDO_CMD=""
	fi
}

clear_state(){
	$DELIMITER
	echo "Clearing the state before the test..."
	python3 manage_images.py -r $ENGINE_FLAG
}

basic_tests(){
	$DELIMITER
	echo "Testing help message printing..."
	python3 -m coverage run -a --branch manage_images.py -h
	$DELIMITER
	echo "Testing image building..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-8 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-11 $ENGINE_FLAG
	$DELIMITER
	echo "Testing quiet image building..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 -q $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-15 -q $ENGINE_FLAG
	$DELIMITER
	echo "Testing image listing..."
	python3 -m coverage run -a --branch manage_images.py -l $ENGINE_FLAG

	$DELIMITER
	echo "Testing image removal..."
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r clang-11 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $ENGINE_FLAG
	$DELIMITER
	echo "Testing building and removing all images..."
	python3 -m coverage run -a --branch manage_images.py -b $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -b all $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r all $ENGINE_FLAG
	$DELIMITER
	echo "Testing building an existing image..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-6 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -b clang-7 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $ENGINE_FLAG
	$DELIMITER
	echo "Testing removing a non-existing image..."
	python3 -m coverage run -a --branch manage_images.py -r gcc-13 $ENGINE_FLAG
	$DELIMITER
	echo "Testing image removal when containers are running..."
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 $ENGINE_FLAG
	$SUDO_CMD $ENGINE run -d --rm --name test-running-1 kernel-build-container:gcc-12 tail -f /dev/null
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r clang-13 $ENGINE_FLAG
	python3 -m coverage run -a --branch manage_images.py -r $ENGINE_FLAG
	$SUDO_CMD $ENGINE stop test-running-1
	python3 -m coverage run -a --branch manage_images.py -r gcc-12 $ENGINE_FLAG
}

test_error_handling(){
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
	python3 -m coverage run -a --branch manage_images.py -b gcc-12 $ENGINE_FLAG
	$SUDO_CMD $ENGINE rmi -f kernel-build-container:gcc-12
	python3 -m coverage run -a --branch manage_images.py -l $ENGINE_FLAG && exit 1
	$SUDO_CMD $ENGINE rmi -f kernel-build-container:clang-13
	python3 -m coverage run -a --branch manage_images.py -l $ENGINE_FLAG
}

test_multiruntime(){
	$DELIMITER
	echo "Testing runtime engine selection and errors handling when multiple container engines installed"
	python3 -m coverage run -a --branch manage_images.py -d -p -l && exit 1
	export PATH_BACK="$PATH"
	export PATH=''
	/usr/bin/python3 -m coverage run -a --branch manage_images.py -l && exit 1
	export PATH="$PATH_BACK"
}

handle_unknow_error(){
	$DELIMITER
	echo "Testing errors handling when engine returned unknow error"
	TMPDIR=$(mktemp -d -t fake-docker.XXXXXX) || { echo "mktemp failed" >&2; exit 3; }
	cat > "$TMPDIR/$ENGINE" <<'EOF'
#!/usr/bin/env bash
#  fake-engine (docker/podman)
#  This stub pretends to be the runtime and always fails on `ps`.
#
#  It writes an error message to stderr (no “permission denied”) and
#  exits with status 1 so that the target script falls into the
#  `sys.exit()` branch.
#
if [[ "$1" == "ps" ]]; then
echo "fake error: cannot execute 'ps'" >&2
exit 1
else
echo "fake runtime: unknown command '$1'" >&2
exit 127
fi
EOF
	chmod +x "$TMPDIR/$ENGINE"
	PATH="$TMPDIR:$PATH" /usr/bin/python3 -m coverage run -a --branch manage_images.py -l $ENGINE_FLAG && exit 1
	rm -rf "$TMPDIR"
}

finish(){
	$DELIMITER
	echo "All tests completed. Creating the coverage report..."
	python3 -m coverage report
	python3 -m coverage html
	echo "Well done!"
}

python3 -m coverage erase

ENGINE='docker'
ENGINE_FLAG="-d"
check_sudo
clear_state
basic_tests
test_error_handling
handle_unknow_error

ENGINE='podman'
ENGINE_FLAG="-p"
check_sudo
echo $SUDO_CMD
clear_state
basic_tests
test_error_handling

handle_unknow_error
test_multiruntime

finish
