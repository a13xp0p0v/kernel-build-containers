#!/usr/bin/env bash
set -eu

DELIMITER="\n##############################################"

SRC_DIR="$PWD/linux_src"
OUT_DIR="$PWD/build_out"
SRC_TARBALL="$PWD/linux_src.tar.xz"
KERNEL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.65.tar.xz"
EXPECTED_CHECKSUM="54e852667af35c0ed06cfc81311e65fa7f5f798a3bfcf78a559d3b4785a139c1"

RUNTIME_FLAG=""
COMPILERS=("gcc-13" "clang-15")
ARCHS=("x86_64" "i386" "arm64" "arm" "riscv" "powerpc" "powerpc64" "powerpc64le")
declare -A EXPECTED_IMAGES=(
	[x86_64]="arch/x86/boot/bzImage"
	[i386]="arch/x86/boot/bzImage"
	[arm64]="arch/arm64/boot/Image.gz"
	[arm]="arch/arm/boot/zImage"
	[riscv]="arch/riscv/boot/Image.gz"
	[powerpc]="arch/powerpc/boot/zImage"
	[powerpc64]="arch/powerpc/boot/zImage"
	[powerpc64le]="arch/powerpc/boot/zImage"
)

FAST=0

if [ "${1:-}" = "--fast" ]; then
	FAST=1
    # We skip kernel compilation anyway
    ARCHS=("x86_64")
fi

fail() {
	echo "[-] $*"
	exit 1
}

prepare_tests() {
	echo -e "$DELIMITER"
	echo "Preparing to the tests..."

	for CMD in wget tar expect; do
		if ! command -v "$CMD" >/dev/null; then
			fail "Make sure these utilities are installed: wget tar expect"
		fi
	done

	if [ -d "$SRC_DIR" ] || [ -d "$OUT_DIR" ]; then
		fail "Some files left from the previous test, remove $SRC_DIR and $OUT_DIR"
	fi

	if [ ! -f "$SRC_TARBALL" ]; then
		wget "$KERNEL" -O "$SRC_TARBALL"
	fi

	CHECKSUM=$(sha256sum "$SRC_TARBALL" | awk '{print $1}')
	if [ "$CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
		fail "Unexpected sha256sum of the $SRC_TARBALL, remove $SRC_TARBALL and restart the test"
	fi

	mkdir -p "$SRC_DIR" "$OUT_DIR"
	tar -xf "$SRC_TARBALL" -C "$SRC_DIR" --strip-components=1

	for COMPILER in "${COMPILERS[@]}"; do
		python3 manage_images.py -d -b "$COMPILER"
		python3 manage_images.py -p -b "$COMPILER"
	done

	echo "[+] Everything is ready for the tests"
}

run_tests() {
	# Use $RUNTIME_FLAG without quotes since it may be empty (default value)

	echo -e "$DELIMITER"
	echo "Testing kernel building..."
	for ARCH in "${ARCHS[@]}"; do
		for COMPILER in "${COMPILERS[@]}"; do
			CONFIG="$OUT_DIR/${ARCH}__$COMPILER/.config"
			test -f "$CONFIG" && fail "Unexpected kernel config detected: $CONFIG"

			python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "$ARCH" -c "$COMPILER" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig
			if [ -f "$CONFIG" ]; then
				echo "[+] Kernel config is generated: $CONFIG"
			else
				fail "Missing $CONFIG after building defconfig"
			fi

			if [ "$FAST" -eq 0 ]; then
				python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "$ARCH" -c "$COMPILER" -s "$SRC_DIR" -o "$OUT_DIR"
				IMAGE="$OUT_DIR/${ARCH}__$COMPILER/${EXPECTED_IMAGES[$ARCH]}"
				if [ -f "$IMAGE" ]; then
					echo "[+] Kernel image is generated: $IMAGE"
				else
					fail "Missing $IMAGE after building the kernel"
				fi
			fi

			# Provide additional arguments for 'make' without the -- delimiter
			python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "$ARCH" -c "$COMPILER" -s "$SRC_DIR" -o "$OUT_DIR" mrproper
		done
	done

	echo -e "$DELIMITER"
	echo "Testing quiet kernel building..."
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -q -- defconfig

	echo -e "$DELIMITER"
	echo "Testing single-cpu kernel building..."
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -t -- defconfig

	echo -e "$DELIMITER"
	echo "Testing kernel building at the directory with the kernel sources..."
	CONFIG="$SRC_DIR/.config"
	test -f "$CONFIG" && fail "Unexpected kernel config detected: $CONFIG"
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -- defconfig
	if [ -f "$CONFIG" ]; then
		echo "[+] Kernel config is generated: $CONFIG"
	else
		fail "Missing $CONFIG after building defconfig"
	fi
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -- mrproper
	test -f "$CONFIG" && fail "Unexpected kernel config detected: $CONFIG"
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$SRC_DIR" -- defconfig
	if [ -f "$CONFIG" ]; then
		echo "[+] Kernel config is generated: $CONFIG"
	else
		fail "Missing $CONFIG after building defconfig"
	fi
	# Now building at some other OUT_DIR should fail (SRC_DIR needs cleaning)
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig && exit 1
	# Clean SRC_DIR and try again
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -- mrproper
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig

	echo -e "$DELIMITER"
	echo "Testing kernel building with the external kernel config..."
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig
	cp "$OUT_DIR/${ARCHS[0]}__${COMPILERS[0]}/.config" "$PWD/testcfg"
	# Test that build_linux.py fails if "-k" is used without "-o"
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -k "$PWD/testcfg" && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -k "$PWD/testcfg"
	# Test that build_linux.py proceeds if the kernel config is similar to one in OUT_DIR
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -k "$PWD/testcfg"
	# Test that build_linux.py fails if the kernel config differs from one in OUT_DIR
	echo "# CONFIG_EXAMPLE_FOOBAR is not set" >>"$PWD/testcfg"
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -k "$PWD/testcfg" && exit 1
	rm "$PWD/testcfg"

	echo -e "$DELIMITER"
	echo "Testing invalid argument combinations (build_linux.py must return an error)..."
	python3 -m coverage run -a --branch build_linux.py -p -d -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- O=invalid && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- ARCH=invalid && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- CROSS_COMPILE=invalid && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- CC=invalid && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- -j1 && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -k /path/INVALID.conf && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s /path/INVALID -o "$OUT_DIR" && exit 1
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o /path/INVALID && exit 1

	echo -e "$DELIMITER"
	echo "Testing interruption handling..."
	python3 -m coverage run -a --branch build_linux.py $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig
	expect <<EOF
spawn python3 -m coverage run -a --branch build_linux.py -t $RUNTIME_FLAG -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR"
set timeout 5
expect {
	timeout {
		puts "--- Sending Ctrl+C ---"
		send "\x03"
	}
}
set timeout 10
expect {
	eof {
		exit 0
	}
	timeout {
		puts "ERROR: build_linux.py didn't stop"
		exit 1
	}
}
EOF

	# Ok, remove all build artifacts
	rm -rf "$OUT_DIR"/*
}

run_menuconfig_test() {
	python3 -m coverage run -a --branch build_linux.py -p -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- mrproper
	python3 -m coverage run -a --branch build_linux.py -p -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- defconfig
	# The following expect script can test menuconfig only with rootless Podman (since Docker requires sudo).
	# Double Esc (0x1b) allows to exit from the menuconfig.
	expect <<EOF
spawn python3 -m coverage run -a --branch build_linux.py -p -a "${ARCHS[0]}" -c "${COMPILERS[0]}" -s "$SRC_DIR" -o "$OUT_DIR" -- menuconfig
set timeout 5
expect {
	timeout {
		send "\x1b"
		send "\x1b"
	}
}
set timeout 10
expect {
	eof {
		exit 0
	}
	timeout {
		exit 1
	}
}
EOF
}

cleanup_after_tests() {
	rm -rf "$OUT_DIR"
	rm -rf "$SRC_DIR"
	rm "$SRC_TARBALL"
}


echo "Let's test build_linux.py..."
prepare_tests
python3 -m coverage erase

# Test Docker as a default container runtime (without a flag)
RUNTIME_FLAG=""
run_tests

# Test Docker
RUNTIME_FLAG="-d"
run_tests

# Test Podman
RUNTIME_FLAG="-p"
run_tests

run_menuconfig_test

echo "All tests completed. Creating the coverage report..."
python3 -m coverage report
python3 -m coverage html

cleanup_after_tests
echo "Well done!"
