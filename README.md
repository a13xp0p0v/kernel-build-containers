# kernel-build-containers

[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/a13xp0p0v/kernel-build-containers?label=release)](https://github.com/a13xp0p0v/kernel-build-containers/tags)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![static analysis](https://github.com/a13xp0p0v/kernel-build-containers/workflows/static%20analysis/badge.svg)](https://github.com/a13xp0p0v/kernel-build-containers/actions/workflows/static_analysis.yml)

This project provides containers for building the Linux kernel (or other software) with many different compilers.

It is a nice solution for the 🔥toolchain hell🔥 problem.

This project is also very useful for testing gcc-plugins for the Linux kernel, for example. Goodbye headache!

`kernel-build-containers` supports __Docker__ and __Podman__ container engines, feel free to choose.

License: GPL-3.0.

## Repositories

 - At GitHub <https://github.com/a13xp0p0v/kernel-build-containers>
 - At Codeberg: <https://codeberg.org/a13xp0p0v/kernel-build-containers> (go there if something goes wrong with GitHub)
 - At SourceCraft: <https://sourcecraft.dev/a13xp0p0v/kernel-build-containers>

## Supported features

__Supported kernel build targets:__
 - `x86_64` (using the default toolchain)
 - `i386` (using the default toolchain)
 - `arm64` (using the `aarch64` toolchain)
 - `arm` (using the `arm` toolchain)
 - `riscv` (using the `riscv64` toolchain)
 - `powerpc` (using one of three toolchains: `powerpc`, `powerpc64`, or `powerpc64le`)

__Supported GCC versions:__

|             | x86_64/i386 | aarch64 | arm | riscv64 | powerpc | powerpc64 | powerpc64le |
| ----------- | ----------- | ------- | --- | ------- | ------- | --------- | ----------- |
| __gcc-4.9__ | ✓           | *       | *   |         | *       |           | *           |
| __gcc-5__   | ✓           | ✓       | ✓   |         | ✓       | ✓         | ✓           |
| __gcc-6__   | ✓           | ✓       | ✓   |         | ✓       | ✓         | ✓           |
| __gcc-7__   | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-8__   | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-9__   | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-10__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-11__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-12__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-13__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-14__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-15__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |
| __gcc-16__  | ✓           | ✓       | ✓   | ✓       | ✓       | ✓         | ✓           |

*\* marks a GCC version that doesn't support `gcc-plugins`*

The containers also provide the corresponding versions of `g++`.

__Supported Clang versions:__

`kernel-build-containers` provides all versions of Clang from `clang-5` to `clang-22`.

The Clang compiler binary and corresponding LLVM utilities typically contain all supported backends for cross compiling.

## How to build container images

__Get help:__

```console
$ python3 manage_images.py -h
usage: manage_images.py [-h] [-d | -p] [-l | -b [compiler] | -r [compiler]] [-q]

Manage the images for kernel-build-containers

options:
  -h, --help            show this help message and exit
  -d, --docker          force to use the Docker container engine (default)
  -p, --podman          force to use the Podman container engine instead of default Docker
  -l, --list            show the container images and their IDs
  -b, --build [compiler]
                        build a container image providing: clang-5 / clang-6 / clang-7 /
                        clang-8 / clang-9 / clang-10 / clang-11 / clang-12 / clang-13 /
                        clang-14 / clang-15 / clang-16 / clang-17 / clang-18 / clang-19 /
                        clang-20 / clang-21 / clang-22 / gcc-4.9 / gcc-5 / gcc-6 / gcc-7 /
                        gcc-8 / gcc-9 / gcc-10 / gcc-11 / gcc-12 / gcc-13 / gcc-14 /
                        gcc-15 / gcc-16 / all ("all" is default, the tool will build all
                        images if no compiler is specified)
  -r, --remove [compiler]
                        remove container images providing: clang-5 / clang-6 / clang-7 /
                        clang-8 / clang-9 / clang-10 / clang-11 / clang-12 / clang-13 /
                        clang-14 / clang-15 / clang-16 / clang-17 / clang-18 / clang-19 /
                        clang-20 / clang-21 / clang-22 / gcc-4.9 / gcc-5 / gcc-6 / gcc-7 /
                        gcc-8 / gcc-9 / gcc-10 / gcc-11 / gcc-12 / gcc-13 / gcc-14 /
                        gcc-15 / gcc-16 / all ("all" is default, the tool will remove all
                        images if no compiler is specified)
  -q, --quiet           suppress the container image build output (for using with --build)
```

__Build a single Docker container image:__

```console
$ python3 manage_images.py -d -b gcc-12
```
or simply run (Docker is the default engine):
```console
$ python3 manage_images.py -b gcc-12
```

__Build a single Podman container image:__

```console
$ python3 manage_images.py -p -b gcc-12
```

__Build a container image quietly:__

```console
$ python3 manage_images.py -d -b clang-11 -q
```

__List container images for the chosen container engine:__

```console
$ python3 manage_images.py -p -l
Force to use the Podman container engine
[!] INFO: Working with Podman images belonging to "a13x" (UID 1000)

Current status:
--------------------------------------------
 Ubuntu | Clang  | GCC    | Podman Image ID
--------------------------------------------
 16.04  | 5      | 4.9    | -
 16.04  | 6      | 5      | -
 18.04  | 7      | 6      | -
 18.04  | 8      | 7      | -
 20.04  | 9      | 8      | -
 20.04  | 10     | 9      | -
 20.04  | 11     | 10     | -
 22.04  | 12     | 11     | -
 22.04  | 13     | 12     | -
 22.04  | 14     | 12     | -
 24.04  | 15     | 13     | ee6bfb42352c
 24.04  | 16     | 14     | b58f6716b499
 24.04  | 17     | 14     | -
 24.04  | 18     | 14     | -
 26.04  | 19     | 15     | dca3c87ef046
 26.04  | 20     | 15     | 60b1c014eabf
 26.04  | 21     | 16     | -
 26.04  | 22     | 16     | -
--------------------------------------------
```

__Build all container images for the chosen container engine:__

```console
$ python3 manage_images.py -d -b all
```
or simply run:
```console
$ python3 manage_images.py -d -b
```

__Expected output after building all images:__

```console
Current status:
--------------------------------------------
 Ubuntu | Clang  | GCC    | Docker Image ID
--------------------------------------------
 16.04  | 5      | 4.9    | eeea78335b02
 16.04  | 6      | 5      | 145f1682a11e
 18.04  | 7      | 6      | 3b207dd913c5
 18.04  | 8      | 7      | 63592d5db90b
 20.04  | 9      | 8      | b782eed97d1b
 20.04  | 10     | 9      | c438ddfdcbd1
 20.04  | 11     | 10     | 1673127409d5
 22.04  | 12     | 11     | d1d25388d38c
 22.04  | 13     | 12     | f47947f485cb
 22.04  | 14     | 12     | a7d0a91f4f07
 24.04  | 15     | 13     | d2890c6ef101
 24.04  | 16     | 14     | 448111f267bd
 24.04  | 17     | 14     | 7f0c4d6a6b18
 24.04  | 18     | 14     | f044bde4f172
 26.04  | 19     | 15     | e206f91fe747
 26.04  | 20     | 15     | 0da2ec69cccc
 26.04  | 21     | 16     | 04f9f2efb289
 26.04  | 22     | 16     | fad6f9889b42
--------------------------------------------
```

The created Docker container images look like this:

```console
$ sudo docker images
IMAGE                             ID             DISK USAGE   CONTENT SIZE   EXTRA
kernel-build-container:clang-10   c438ddfdcbd1       2.12GB             0B        
kernel-build-container:clang-11   1673127409d5       2.45GB             0B        
kernel-build-container:clang-12   d1d25388d38c       2.61GB             0B        
kernel-build-container:clang-13   f47947f485cb        2.9GB             0B        
kernel-build-container:clang-14   a7d0a91f4f07       2.82GB             0B        
kernel-build-container:clang-15   d2890c6ef101       2.88GB             0B        
kernel-build-container:clang-16   448111f267bd       3.35GB             0B        
kernel-build-container:clang-17   7f0c4d6a6b18       3.33GB             0B        
kernel-build-container:clang-18   f044bde4f172       3.38GB             0B        
kernel-build-container:clang-19   e206f91fe747       3.32GB             0B        
kernel-build-container:clang-20   0da2ec69cccc       3.38GB             0B        
kernel-build-container:clang-21   04f9f2efb289       6.74GB             0B        
kernel-build-container:clang-22   fad6f9889b42        6.8GB             0B        
kernel-build-container:clang-5    eeea78335b02        2.1GB             0B        
kernel-build-container:clang-6    145f1682a11e       1.73GB             0B        
kernel-build-container:clang-7    3b207dd913c5       1.93GB             0B        
kernel-build-container:clang-8    63592d5db90b          2GB             0B        
kernel-build-container:clang-9    b782eed97d1b       2.26GB             0B        
kernel-build-container:gcc-10     1673127409d5       2.45GB             0B        
kernel-build-container:gcc-11     d1d25388d38c       2.61GB             0B        
kernel-build-container:gcc-12     a7d0a91f4f07       2.82GB             0B        
kernel-build-container:gcc-13     d2890c6ef101       2.88GB             0B        
kernel-build-container:gcc-14     f044bde4f172       3.38GB             0B        
kernel-build-container:gcc-15     0da2ec69cccc       3.38GB             0B        
kernel-build-container:gcc-16     fad6f9889b42        6.8GB             0B        
kernel-build-container:gcc-4.9    eeea78335b02        2.1GB             0B        
kernel-build-container:gcc-5      145f1682a11e       1.73GB             0B        
kernel-build-container:gcc-6      3b207dd913c5       1.93GB             0B        
kernel-build-container:gcc-7      63592d5db90b          2GB             0B        
kernel-build-container:gcc-8      b782eed97d1b       2.26GB             0B        
kernel-build-container:gcc-9      c438ddfdcbd1       2.12GB             0B        
```

## How to run a container

__Get help:__

```console
$ bash start_container.sh
usage: start_container.sh compiler src_dir out_dir [-h] [-d | -p] [-n] [-e VAR] [-v] [-- cmd with args]
  -h    print this help
  -d    force to use the Docker container engine (default)
  -p    force to use the Podman container engine instead of default Docker
  -n    launch container in non-interactive mode
  -e    add environment variable in the container (may be used multiple times)
  -v    enable debug output

  If cmd is empty, we will start an interactive bash in the container.
```

__Run interactive bash in the container:__

```console
$ bash start_container.sh gcc-12 ~/linux-stable/linux-stable/ ~/linux-stable/build_out/
Docker container engine is chosen (default)
Hey, we gonna use sudo for running the container
Starting "kernel-build-container:gcc-12"
Gonna run the container in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable/" at "/src"
Mount build output directory "/home/a13x/linux-stable/build_out/" at "/out"
Gonna run bash

a13x@1f9c2baec240:/src$
```

__Execute a command in the container:__

```console
$ bash start_container.sh clang-15 ~/linux-stable/linux-stable/ ~/linux-stable/build_out/ -- make defconfig
Docker container engine is chosen (default)
Hey, we gonna use sudo for running the container
Starting "kernel-build-container:clang-15"
Gonna run the container in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable/" at "/src"
Mount build output directory "/home/a13x/linux-stable/build_out/" at "/out"
Gonna run command "make defconfig"

*** Default configuration is based on 'x86_64_defconfig'
...
```

## How to build the Linux kernel

__Get help:__

```console
$ python3 build_linux.py --help
usage: build_linux.py [-h] [-d | -p] -a ARCH -c COMPILER [-k KCONFIG] -s SRC [-o OUT] [-q]
                      [-t]
                      ...

Build Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by -- delimiter

options:
  -h, --help            show this help message and exit
  -d, --docker          force to use the Docker container engine (default)
  -p, --podman          force to use the Podman container engine instead of default Docker
  -a, --arch ARCH       build target architecture (x86_64 / i386 / arm64 / arm / riscv /
                        powerpc / powerpc64 / powerpc64le)
  -c, --compiler COMPILER
                        compiler for building (clang-5 / clang-6 / clang-7 / clang-8 /
                        clang-9 / clang-10 / clang-11 / clang-12 / clang-13 / clang-14 /
                        clang-15 / clang-16 / clang-17 / clang-18 / clang-19 / clang-20 /
                        clang-21 / clang-22 / gcc-4.9 / gcc-5 / gcc-6 / gcc-7 / gcc-8 /
                        gcc-9 / gcc-10 / gcc-11 / gcc-12 / gcc-13 / gcc-14 / gcc-15 /
                        gcc-16)
  -k, --kconfig KCONFIG
                        path to kernel kconfig file (optional argument)
  -s, --src SRC         Linux kernel sources directory
  -o, --out OUT         build output directory, where the output subdirectory
                        "kconfig__arch__compiler" is created. Without '-k', the output
                        subdirectory name format is "arch__compiler". For in-place building
                        of Linux at the root of the kernel source tree, you can specify the
                        same '-s' and '-o' path without '-k' or simply run the tool without
                        '-o' and '-k' arguments.
  -q, --quiet           for running `make` in quiet mode
  -t, --single-thread   for running `make` in single-threaded mode (multi-threaded by
                        default)
```

__Configure the Linux kernel with `menuconfig` in the needed container:__

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- menuconfig
Docker container engine is chosen (default)
Going to build the Linux kernel for arm64
Going to build with gcc-13
Using "/home/a13x/linux-stable/experiment.config" as kernel config
Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
Using "/home/a13x/linux-stable/build_out" as build output directory
Have additional arguments for 'make': menuconfig
Going to run 'make' on 6 CPUs
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory doesn't exist, create it
No ".config", copy "/home/a13x/linux-stable/experiment.config" to "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config"
Going to run the container in the interactive mode (without build log)
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 --docker -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 6 menuconfig
Force to use the Docker container engine
Hey, we gonna use sudo for running the container
Starting "kernel-build-container:gcc-13"
Gonna run the container in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/src"
Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/out"
Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 6 menuconfig"

make[1]: Entering directory '/out'
  GEN     Makefile
...
*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

make[1]: Leaving directory '/out'
The container's return code 0
Finishing the container
Only remove the container id file:
    Search "container.id" file in build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13"
    NO such file, nothing to do, exit
The finish_container.sh script returned 2
Done, see the results
```

__Build the Linux kernel in the needed container saving the build output into a separate directory:__

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
Docker container engine is chosen (default)
Going to build the Linux kernel for arm64
Going to build with gcc-13
Using "/home/a13x/linux-stable/experiment.config" as kernel config
Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
Using "/home/a13x/linux-stable/build_out" as build output directory
Going to run 'make' on 6 CPUs
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
The kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" are identical, proceed
Going to write the build log to "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/build_log.txt"
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 --docker -n -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 6
    Force to use the Docker container engine
    Gonna run the container in NON-interactive mode
    Hey, we gonna use sudo for running the container
    Starting "kernel-build-container:gcc-13"
    Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/src"
    Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/out"
    Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 6"
    
    make[1]: Entering directory '/out'
      SYNC    include/config/auto.conf.cmd
      GEN     Makefile
...
    make[1]: Leaving directory '/out'
The container's return code 0
Finishing the container
Only remove the container id file:
    Search "container.id" file in build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13"
    Hey, we gonna use sudo for running the container
    OK, "container.id" file exists, removing it
    OK, container b2bf9c17705ae1786898ef2755dd340c7d8e6e459faaf1534b5d0059281f4bab doesn't run
The finish_container.sh script returned 0
See the build log: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/build_log.txt
Done, see the results
```

The tool returns an error if the kconfig file specified with `-k` differs from the `.config` in the build output directory:

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
Docker container engine is chosen (default)
Going to build the Linux kernel for arm64
Going to build with gcc-13
Using "/home/a13x/linux-stable/experiment.config" as kernel config
Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
Using "/home/a13x/linux-stable/build_out" as build output directory
Going to run 'make' on 6 CPUs
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
The kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" differ, stop
[-] ERROR: Kconfig files are different, check the diff and consider copying
```

In that case please check the diff and synchronize the kconfig files:

```console
 diff ~/linux-stable/experiment.config ~/linux-stable/build_out/experiment__arm64__gcc-13/.config
152c152
< CONFIG_IKCONFIG_PROC=y
---
> # CONFIG_IKCONFIG_PROC is not set
$ cp ~/linux-stable/build_out/experiment__arm64__gcc-13/.config ~/linux-stable/experiment.config
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
```

__Build the Linux kernel in the needed container at the root of the kernel source tree (in-place)__

For in-place building of Linux at the root of the kernel source tree, you can either:
 - Specify the same `-s` and `-o` path without `-k`,
 - Or simply run the tool without `-o` and `-k` arguments.

```console
$ python3 build_linux.py -c clang-16 -a x86_64 -s ~/linux-stable/linux-stable -- defconfig
Docker container engine is chosen (default)
Going to build the Linux kernel for x86_64
Going to build with clang-16
Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
Have additional arguments for 'make': defconfig
Going to run 'make' on 6 CPUs
No '-k' and '-o' arguments; skip creating an output subdirectory to allow in-place build
Output subdirectory for this build: /home/a13x/linux-stable/linux-stable
Output subdirectory already exists, use it (no cleaning!)
No kconfig to copy to the output subdirectory
Going to write the build log to "/home/a13x/linux-stable/linux-stable/build_log.txt"
Going to build the kernel in-place (without 'O=')
Add arguments for compiling with clang: CC=clang
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh clang-16 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/linux-stable --docker -n -- make CC=clang -j 6 defconfig
    Force to use the Docker container engine
    Gonna run the container in NON-interactive mode
    Hey, we gonna use sudo for running the container
    Starting "kernel-build-container:clang-16"
    Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/src"
    Mount build output directory "/home/a13x/linux-stable/linux-stable" at "/out"
    Gonna run command "make CC=clang -j 6 defconfig"
    
      HOSTCC  scripts/basic/fixdep
      HOSTCC  scripts/kconfig/conf.o
...
    *** Default configuration is based on 'x86_64_defconfig'
    #
    # configuration written to .config
    #
The container's return code 0
Finishing the container
Only remove the container id file:
    Search "container.id" file in build output directory "/home/a13x/linux-stable/linux-stable"
    Hey, we gonna use sudo for running the container
    OK, "container.id" file exists, removing it
    OK, container adcf6f32a5e1106405e892c2fa048a33c504d5b6f3761979fd054bb3134619d9 doesn't run
The finish_container.sh script returned 0
See the build log: /home/a13x/linux-stable/linux-stable/build_log.txt
Done, see the results
```

## How to remove the created container images

__Remove the container image(s) providing one given compiler:__

```console
$ python3 manage_images.py -r gcc-12
```

__Remove all created images:__

```console
$ python3 manage_images.py -r all
```
or simply
```console
$ python3 manage_images.py -r
```

__Expected output, if the containers are not running:__

```console
Docker container engine is chosen (default)
[!] INFO: We need "sudo" for working with Docker containers
...

Current status:
--------------------------------------------
 Ubuntu | Clang  | GCC    | Docker Image ID
--------------------------------------------
 16.04  | 5      | 4.9    | -
 16.04  | 6      | 5      | -
 18.04  | 7      | 6      | -
 18.04  | 8      | 7      | -
 20.04  | 9      | 8      | -
 20.04  | 10     | 9      | -
 20.04  | 11     | 10     | -
 22.04  | 12     | 11     | -
 22.04  | 13     | 12     | -
 22.04  | 14     | 12     | -
 24.04  | 15     | 13     | -
 24.04  | 16     | 14     | -
 24.04  | 17     | 14     | -
 24.04  | 18     | 14     | -
 26.04  | 19     | 15     | -
 26.04  | 20     | 15     | -
 26.04  | 21     | 16     | -
 26.04  | 22     | 16     | -
--------------------------------------------
```

__Expected output, if some containers are running:__

```console
...
Remove the container image d2890c6ef101 providing Clang 15 and GCC 13
[!] WARNING: Removing the image d2890c6ef101 failed, some containers use it
...
[!] WARNING: failed to remove 1 container image(s), see the log above

Current status:
--------------------------------------------
 Ubuntu | Clang  | GCC    | Docker Image ID
--------------------------------------------
 16.04  | 5      | 4.9    | -
 16.04  | 6      | 5      | -
 18.04  | 7      | 6      | -
 18.04  | 8      | 7      | -
 20.04  | 9      | 8      | -
 20.04  | 10     | 9      | -
 20.04  | 11     | 10     | -
 22.04  | 12     | 11     | -
 22.04  | 13     | 12     | -
 22.04  | 14     | 12     | -
 24.04  | 15     | 13     | d2890c6ef101
 24.04  | 16     | 14     | -
 24.04  | 17     | 14     | -
 24.04  | 18     | 14     | -
 26.04  | 19     | 15     | -
 26.04  | 20     | 15     | -
 26.04  | 21     | 16     | -
 26.04  | 22     | 16     | -
--------------------------------------------
```

In that case simply stop this container and run `manage_images.py -r` again.

## Notes for developers

If you change the code of `kernel-build-containers`, please run the tests (see the `./tests/` directory).

### Testing `manage_images.py`

```console
$ bash tests/tests_for_manage_images.sh
```

This script tests creating and removing `kernel-build-containers` images in Docker and Podman using `manage_images.py`.

The code coverage of this test is stored in `htmlcov/index.html`.

> [!NOTE]
> Running `tests_for_manage_images.sh` requires at least 100 GiB of free disk space on your system.

Building all the container images during this test is quite slow. But you can make it faster if you populate the cache in Docker and Podman before running `tests_for_manage_images.sh`:

```console
$ bash tests/speedrun_for_manage_images.sh
```

This script builds and removes all `kernel-build-containers` images in Docker to populate its build cache, which makes further building fast.

However, this trick doesn't work for Podman, because the Podman runtime unfortunately removes the intermediate image layers on image deletion. That's why `speedrun_for_manage_images.sh` creates special tags for the `kernel-build-containers` image layers to preserve them and make further building fast as well.

To remove the `kernel-build-containers` artifacts created by `speedrun_for_manage_images.sh` and `tests_for_manage_images.sh`, run this command:

```console
$ bash tests/speedrun_for_manage_images.sh --clean
```

You can also check `docker system df -v` and `podman system df -v` to see what else to clean on your system using the `prune` command (be careful).

### Testing `build_linux.py`

Full test for building the Linux kernel:

```console
$ bash tests/tests_for_build_linux.sh
```

Fast mode: test only `x86_64` and skip building kernel images (has less code coverage):

```console
$ bash tests/tests_for_build_linux.sh --fast
```

The code coverage of this test is stored in `htmlcov/index.html`.

## Have fun!
