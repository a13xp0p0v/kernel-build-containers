# kernel-build-containers

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

It's very useful for testing gcc-plugins for the Linux kernel, for example. Goodbye headache!

## Repositories

 - Main at GitHub <https://github.com/a13xp0p0v/kernel-build-containers>
 - Mirror at Codeberg: <https://codeberg.org/a13xp0p0v/kernel-build-containers>
 - Mirror at GitFlic: <https://gitflic.ru/project/a13xp0p0v/kernel-build-containers>

## Supported features

__Supported build targets:__
 - `x86_64`
 - `i386`
 - `arm64` or `aarch64`
 - `arm` or `aarch32`

__Supported gcc versions:__
 - gcc-4.9 (doesn't support `gcc-plugins` for `arm64` and `arm`)
 - gcc-5
 - gcc-6
 - gcc-7
 - gcc-8
 - gcc-9
 - gcc-10
 - gcc-11
 - gcc-12
 - gcc-13

__Supported clang versions:__
 - clang-12
 - clang-13
 - clang-14
 - clang-15

## Usage

### Building all containers

```console
$ sh build_containers.sh
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
kernel-build-container   gcc-13     da5490de8c72   3 hours ago     3.14GB
kernel-build-container   clang-15   317bcc9cbe7e   2 months ago    2.34GB
kernel-build-container   clang-14   2801a41dc153   2 months ago    1.69GB
kernel-build-container   clang-13   155ea2d3f4ad   2 months ago    2.28GB
kernel-build-container   gcc-12     283a273fa54d   2 months ago    3.03GB
kernel-build-container   clang-12   b4891e3c38aa   9 months ago    3.68GB
kernel-build-container   gcc-11     443c02ccc2eb   9 months ago    1.01GB
kernel-build-container   gcc-10     e1ad5c23c709   9 months ago    1.25GB
kernel-build-container   gcc-9      7980321acf8e   9 months ago    816MB
kernel-build-container   gcc-8      50fedf287444   9 months ago    1.11GB
kernel-build-container   gcc-7      40d953aaef4a   9 months ago    736MB
kernel-build-container   gcc-6      dcd304714792   9 months ago    988MB
kernel-build-container   gcc-5      3bf57a4d2283   9 months ago    723MB
kernel-build-container   gcc-4.9    8b7c32b723f1   9 months ago    916MB
```

### Running a container

Get help:

```console
$ sh ./start_container.sh
usage: ./start_container.sh compiler src_dir out_dir [-n] [cmd with args]
  use '-n' for non-interactive session
  if cmd is empty, we will start an interactive bash in the container
```

Run interactive bash in the container:

```console
$ sh start_container.sh gcc-10 ~/linux/linux/ ~/linux/build_out/
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-10"
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Run docker in interactive mode
Gonna run interactive bash...
```

Execute a command in the container:

```console
$ sh start_container.sh clang-12 ~/linux/linux/ ~/linux/build_out/ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang defconfig
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:clang-12"
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Run docker in interactive mode
Gonna run "make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang defconfig"
```

### Building Linux kernel

Get help:

```console
$ python3 make_linux.py -h
usage: make_linux.py [-h] -a {x86_64,i386,arm64,arm} [-k kconfig] -s src -o out -c
                     {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,gcc-13,clang-12,clang-13,clang-14,clang-15,all}
                     ...

Build Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by -- delimiter

options:
  -h, --help            show this help message and exit
  -a {x86_64,i386,arm64,arm}
                        build target architecture
  -k kconfig            path to kernel kconfig file
  -s src                Linux kernel sources directory
  -o out                Build output directory
  -c {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,gcc-13,clang-12,clang-13,clang-14,clang-15,all}
                        building compiler ('all' to build with each of them)
```

Kernel building example:

```console
$ python3 make_linux.py -a arm64 -k ~/linux/experiment.config -s ~/linux/linux -o ~/linux/build_out -c clang-12 -- -j5
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux/experiment.config" as kernel config
[+] Using "/home/a13x/linux/linux" as Linux kernel sources directory
[+] Using "/home/a13x/linux/build_out" as build output directory
[+] Going to build with: clang-12
[+] Have additional arguments for 'make': -j5

=== Building with clang-12 ===
Output subdirectory for this build: /home/a13x/linux/build_out/experiment__arm64__clang-12
Output subdirectory doesn't exist, create it
Copy kconfig to output subdirectory as ".config"
Going to save build log to "build_log.txt" in output subdirectory
Compiling with clang requires 'CC=clang'
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh clang-12 /home/a13x/linux/linux /home/a13x/linux/build_out/experiment__arm64__clang-12 -n make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:clang-12"
    Source code directory "/home/a13x/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/linux/build_out/experiment__arm64__clang-12" is mounted at "~/out"
    Run docker in NON-interactive mode
    Gonna run "make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      SYNC    include/config/auto.conf.cmd
      GEN     Makefile
...
    make[1]: Leaving directory '/home/a13x/out'
The container returned 0
See build log: /home/a13x/develop_local/linux-stable/build_out/experiment__arm64__clang-12/build_log.txt
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/develop_local/linux-stable/build_out/experiment__arm64__clang-12"
    OK, "container.id" file exists, removing it
    OK, container 99154aa0bc294a054585c89f71c09b07c0eafb19204e64e23ff22d6db2a9a637 doesn't run
Finished with the container

[+] Done, see the results
```

### Finishing with the container

That tool is used by `make_linux.py` for fast stopping the kernel build.

Get help:

```console
usage: ./finish_container.sh kill/nokill out_dir
  kill/nokill -- how to finish: kill the container and then clean up / only clean up
  out_dir -- build output directory used by this container (with container.id file)
```

### Removing created Docker images

```console
$ sh rm_containers.sh
```
