# kernel-build-containers

[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/a13xp0p0v/kernel-build-containers?label=release)](https://github.com/a13xp0p0v/kernel-build-containers/tags)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

License: GPL-3.0.

It's very useful for testing gcc-plugins for the Linux kernel, for example. Goodbye headache!

## Repositories

 - At GitHub <https://github.com/a13xp0p0v/kernel-build-containers>
 - At Codeberg: <https://codeberg.org/a13xp0p0v/kernel-build-containers> (go there if something goes wrong with GitHub)
 - At GitFlic: <https://gitflic.ru/project/a13xp0p0v/kernel-build-containers>

## Supported features

__Supported build targets:__
 - `x86_64`
 - `i386`
 - `arm64` (toolchain name `aarch64`)
 - `arm`
 - `riscv` (toolchain name `riscv64`)

__Supported gcc versions:__
 - gcc-4.9 (doesn't support `gcc-plugins` for `arm64` and `arm`)
 - gcc-5
 - gcc-6
 - gcc-7 (`riscv` support starts from this version)
 - gcc-8
 - gcc-9
 - gcc-10
 - gcc-11
 - gcc-12
 - gcc-13
 - gcc-14

__Supported clang versions:__
 - clang-5
 - clang-6
 - clang-7
 - clang-8
 - clang-9
 - clang-10
 - clang-11
 - clang-12
 - clang-13
 - clang-14
 - clang-15
 - clang-16
 - clang-17

## How to build container images

__Get help:__

```console
$ python3 manage_images.py -h
usage: manage_images.py [-h] [-l] [-b compiler] [-q] [-r]

Manage the images for kernel-build-containers

options:
  -h, --help            show this help message and exit
  -l, --list            show the container images and their IDs
  -b, --build compiler  build a container image providing clang-5 / clang-6 / clang-7 /
                        clang-8 / clang-9 / clang-10 / clang-11 / clang-12 / clang-13 /
                        clang-14 / clang-15 / clang-16 / clang-17 /
                        gcc-4.9 / gcc-5 / gcc-6 / gcc-7 / gcc-8 / gcc-9 / gcc-10 / gcc-11 /
                        gcc-12 / gcc-13 / gcc-14 / all (use "all" for building all images)
  -q, --quiet           suppress the container image build output (for using with --build)
  -r, --remove          remove all created images
```

__Build a single container image:__

```console
$ python3 manage_images.py -b gcc-12
```

__Build a container image quietly:__

```console
$ python3 manage_images.py -b clang-11 -q
```

__List container images:__

```console
$ python3 manage_images.py -l
We need "sudo" for working with containers

Current status:
-----------------------------------------
 Ubuntu | Clang  | GCC    | Image ID
-----------------------------------------
 16.04  | 5      | 4.9    | -
 16.04  | 6      | 5      | -
 18.04  | 7      | 6      | -
 18.04  | 8      | 7      | -
 20.04  | 9      | 8      | -
 20.04  | 10     | 9      | -
 20.04  | 11     | 10     | 4b575e530b96
 22.04  | 12     | 11     | -
 22.04  | 13     | 12     | 42108f7cd499
 22.04  | 14     | 12     | -
 24.04  | 15     | 13     | -
 24.04  | 16     | 14     | -
 24.04  | 17     | 14     | -
-----------------------------------------
```

__Build all container images:__

```console
$ python3 manage_images.py -b all
```

__Expected output after building all images:__

```console
Current status:
-----------------------------------------
 Ubuntu | Clang  | GCC    | Image ID
-----------------------------------------
 16.04  | 5      | 4.9    | 84de06274519
 16.04  | 6      | 5      | 9f1a2dd62fdd
 18.04  | 7      | 6      | 112aac42ce4c
 18.04  | 8      | 7      | 9aba209703da
 20.04  | 9      | 8      | c1e7857ea7b9
 20.04  | 10     | 9      | 70773f4ade91
 20.04  | 11     | 10     | 794661e2251e
 22.04  | 12     | 11     | a3edfb04cb59
 22.04  | 13     | 12     | fd3d31b4b29b
 22.04  | 14     | 12     | 9f78a073c0a2
 24.04  | 15     | 13     | a48106dc194e
 24.04  | 16     | 14     | 1c0aba835f6c
 24.04  | 17     | 14     | 18f5a5c70571
-----------------------------------------
```

__Created container images:__

```console
$ sudo docker images
REPOSITORY               TAG        IMAGE ID       CREATED          SIZE
kernel-build-container   clang-17   18f5a5c70571   4 seconds ago    2.14GB
kernel-build-container   gcc-14     18f5a5c70571   4 seconds ago    2.14GB
kernel-build-container   clang-16   1c0aba835f6c   2 minutes ago    2.16GB
kernel-build-container   clang-15   a48106dc194e   4 minutes ago    1.87GB
kernel-build-container   gcc-13     a48106dc194e   4 minutes ago    1.87GB
kernel-build-container   clang-14   9f78a073c0a2   6 minutes ago    1.89GB
kernel-build-container   gcc-12     9f78a073c0a2   6 minutes ago    1.89GB
kernel-build-container   clang-13   fd3d31b4b29b   8 minutes ago    1.97GB
kernel-build-container   clang-12   a3edfb04cb59   10 minutes ago   1.73GB
kernel-build-container   gcc-11     a3edfb04cb59   10 minutes ago   1.73GB
kernel-build-container   clang-11   794661e2251e   12 minutes ago   1.62GB
kernel-build-container   gcc-10     794661e2251e   12 minutes ago   1.62GB
kernel-build-container   clang-10   70773f4ade91   14 minutes ago   1.39GB
kernel-build-container   gcc-9      70773f4ade91   14 minutes ago   1.39GB
kernel-build-container   clang-9    c1e7857ea7b9   16 minutes ago   1.56GB
kernel-build-container   gcc-8      c1e7857ea7b9   16 minutes ago   1.56GB
kernel-build-container   clang-8    9aba209703da   18 minutes ago   1.4GB
kernel-build-container   gcc-7      9aba209703da   18 minutes ago   1.4GB
kernel-build-container   clang-7    112aac42ce4c   20 minutes ago   1.5GB
kernel-build-container   gcc-6      112aac42ce4c   20 minutes ago   1.5GB
kernel-build-container   clang-6    9f1a2dd62fdd   21 minutes ago   1.33GB
kernel-build-container   gcc-5      9f1a2dd62fdd   21 minutes ago   1.33GB
kernel-build-container   clang-5    84de06274519   23 minutes ago   1.88GB
kernel-build-container   gcc-4.9    84de06274519   23 minutes ago   1.88GB
```

## How to run a container

__Get help:__

```console
$ bash start_container.sh
Hey, we gonna use sudo for running docker
usage: start_container.sh compiler src_dir out_dir [-n] [-e VAR] [-h] [-v] [-- cmd with args]
  -n    launch container in non-interactive mode
  -e    add environment variable in the container (may be used multiple times)
  -h    print this help
  -v    enable debug output

  If cmd is empty, we will start an interactive bash in the container.
```

__Run interactive bash in the container:__

```console
$ bash start_container.sh gcc-12 ~/linux-stable/linux-stable/ ~/linux-stable/build_out/
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-12"
Gonna run docker in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable/" at "/home/a13x/src"
Mount build output directory "/home/a13x/linux-stable/build_out/" at "/home/a13x/out"
Gonna run bash

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

a13x@38f63939b504:~/src$
```

__Execute a command in the container:__

```console
$ bash start_container.sh clang-15 ~/linux-stable/linux-stable/ ~/linux-stable/build_out/ -- make defconfig
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:clang-15"
Gonna run docker in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable/" at "/home/a13x/src"
Mount build output directory "/home/a13x/linux-stable/build_out/" at "/home/a13x/out"
Gonna run command "make defconfig"

*** Default configuration is based on 'x86_64_defconfig'
...
```

## How to build the Linux kernel

__Get help:__

```console
$ python3 build_linux.py --help
usage: build_linux.py [-h] -c COMPILER -a ARCH -s SRC -o OUT [-k KCONFIG] [-q] [-t] ...

Build Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by -- delimiter

options:
  -h, --help            show this help message and exit
  -c, --compiler COMPILER
                        compiler for building (clang-5 / clang-6 / clang-7 /
                        clang-8 / clang-9 / clang-10 / clang-11 / clang-12 /
                        clang-13 / clang-14 / clang-15 / clang-16 / clang-17 /
                        gcc-4.9 / gcc-5 / gcc-6 / gcc-7 / gcc-8 / gcc-9 / gcc-10 /
                        gcc-11 / gcc-12 / gcc-13 / gcc-14)
  -a, --arch ARCH       build target architecture (x86_64 / i386 / arm64 / arm / riscv)
  -s, --src SRC         Linux kernel sources directory
  -o, --out OUT         build output directory
  -k, --kconfig KCONFIG
                        path to kernel kconfig file
  -q, --quiet           for running `make` in quiet mode
  -t, --single-thread   for running `make` in single-threaded mode (multi-threaded by default)
```

__Configure the Linux kernel with `menuconfig` in the needed container:__

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- menuconfig
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Have additional arguments for 'make': menuconfig
[+] Going to run 'make' on 8 CPUs

=== Building with gcc-13 ===
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" are identical, proceed
Going to run the container in the interactive mode (without build log)
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 8 menuconfig
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-13"
Gonna run docker in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/home/a13x/src"
Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/home/a13x/out"
Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 8 menuconfig"

make[1]: Entering directory '/home/a13x/out'
  GEN     Makefile

...

*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

make[1]: Leaving directory '/home/a13x/out'
The container returned 0
Finish building the kernel
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13"
    NO such file, nothing to do, exit
The finish_container.sh script returned 2

[+] Done, see the results
```

__Build the Linux kernel in the needed container:__

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Going to run 'make' on 8 CPUs

=== Building with gcc-13 ===
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" are identical, proceed
Going to save build log to "build_log.txt" in output subdirectory
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 -n -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 8 2>&1
    Hey, we gonna use sudo for running docker
    Run docker in NON-interactive mode
    Starting "kernel-build-container:gcc-13"
    Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/home/a13x/src"
    Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/home/a13x/out"
    Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 8 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      GEN     Makefile
...
    make[1]: Leaving directory '/home/a13x/out'
The container returned 0
Finish building the kernel
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13"
    OK, "container.id" file exists, removing it
    OK, container a2e51ec1524e247cc5d3d861c106bbc7fd584e970dba1e0f1c960b736a55dfc8 doesn't run
The finish_container.sh script returned 0
See the build log: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/build_log.txt

[+] Done, see the results
```

The tool returns an error if the kconfig file specified with `-k` differs from the `.config` in the build output directory:

```console
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Going to run 'make' on 8 CPUs

=== Building with gcc-13 ===
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" differ, stop
[!] ERROR: kconfig files are different, check the diff and consider copying
```

In that case please check the diff and synchronize the kconfig files:

```console
$ diff ~/linux-stable/experiment.config ~/linux-stable/build_out/experiment__arm64__gcc-13/.config
1622,1623c1622
< CONFIG_NFC_S3FWRN5=m
< CONFIG_NFC_S3FWRN5_I2C=m
---
> # CONFIG_NFC_S3FWRN5_I2C is not set
$ cp ~/linux-stable/build_out/experiment__arm64__gcc-13/.config ~/linux-stable/experiment.config
$ python3 build_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
```

## How to remove the created container images

__Remove all created images:__

```console
$ python3 manage_images.py -r
```

__Expected output, if the containers are not running:__

```console
Current status:
-----------------------------------------
 Ubuntu | Clang  | GCC    | Image ID
-----------------------------------------
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
-----------------------------------------
```

__Expected output, if some containers are running:__

```console
Remove the container image providing Clang 17 and GCC 14
Error response from daemon: conflict: unable to delete 18f5a5c70571 (cannot be forced) - image is being used by running container e322f234ee1b
[!] WARNING: Image removal failed, see the error message above

[!] WARNING: failed to remove 1 container image(s), see the log above

Current status:
-----------------------------------------
 Ubuntu | Clang  | GCC    | Image ID
-----------------------------------------
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
 24.04  | 17     | 14     | 18f5a5c70571
-----------------------------------------
```

In that case simply stop this container and run `manage_images.py -r` again.

## Notes for developers

If you change `manage_images.py`, please run the test:

```console
$ bash test_image_mgmt.sh
```

The code coverage will be stored in `htmlcov/index.html`.

Have fun!
