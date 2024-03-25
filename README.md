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
$ bash build_containers.sh
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
kernel-build-container   clang-15   d4f4cf00a72e   8 minutes ago    2.89GB
kernel-build-container   clang-14   936d0ba7b3be   14 minutes ago   2.24GB
kernel-build-container   clang-13   48b2be56f16e   20 minutes ago   2.3GB
kernel-build-container   clang-12   59375a367e1c   24 minutes ago   2.24GB
kernel-build-container   gcc-13     984309a9530b   30 minutes ago   3.16GB
kernel-build-container   gcc-12     beaa29ee4f70   35 minutes ago   1.58GB
kernel-build-container   gcc-11     281b64f99202   38 minutes ago   1.06GB
kernel-build-container   gcc-10     5c2e53ad97ab   41 minutes ago   1.29GB
kernel-build-container   gcc-9      8a5fc6ae1efd   44 minutes ago   858MB
kernel-build-container   gcc-8      6df704a622bb   46 minutes ago   1.15GB
kernel-build-container   gcc-7      0fde86ef5daa   48 minutes ago   751MB
kernel-build-container   gcc-6      1873e65687a0   50 minutes ago   1GB
kernel-build-container   gcc-5      7ce77323fe88   53 minutes ago   720MB
kernel-build-container   gcc-4.9    59a288b6f07a   55 minutes ago   913MB
```

### Running a container

Get help:

```console
$ bash ./start_container.sh
Hey, we gonna use sudo for running docker
usage: ./start_container.sh compiler src_dir out_dir [-n] [-e VAR] [-h] [-v] [-- cmd with args]
  -n    launch container in non-interactive mode
  -e    add environment variable in the container (may be used multiple times)
  -h    print this help
  -v    enable debug output

  If cmd is empty, we will start an interactive bash in the container.
```

Run interactive bash in the container:

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

Execute a command in the container:

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

### Building Linux kernel

Get help:

```console
$ python3 make_linux.py -h
usage: make_linux.py [-h] -a {x86_64,i386,arm64,arm} [-k kconfig] -s src -o out -c
                     {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,
                     gcc-13,clang-12,clang-13,clang-14,clang-15,all}
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
  -o out                build output directory
  -c {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,gcc-13,
  clang-12,clang-13,clang-14,clang-15,all}
                        building compiler ('all' to build with each of them)
```

Configure the Linux kernel with `menuconfig` in the needed container:

```console
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- menuconfig
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Have additional arguments for 'make': menuconfig

=== Building with gcc-13 ===
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory doesn't exist, create it
No ".config", copy "/home/a13x/linux-stable/experiment.config" to "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config"
Going to run the container in the interactive mode (without build log)
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-13"
Gonna run docker in interactive mode
Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/home/a13x/src"
Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/home/a13x/out"
Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig"

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

Build the Linux kernel in the needed container:

```console
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- -j12
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Have additional arguments for 'make': -j12

=== Building with gcc-13 ===
Output subdirectory for this build: /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13
Output subdirectory already exists, use it (no cleaning!)
kconfig files "/home/a13x/linux-stable/experiment.config" and "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13/.config" are identical, proceed
Going to save build log to "build_log.txt" in output subdirectory
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh gcc-13 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/build_out/experiment__arm64__gcc-13 -n -- make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j12 2>&1
    Hey, we gonna use sudo for running docker
    Run docker in NON-interactive mode
    Starting "kernel-build-container:gcc-13"
    Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/home/a13x/src"
    Mount build output directory "/home/a13x/linux-stable/build_out/experiment__arm64__gcc-13" at "/home/a13x/out"
    Gonna run command "make O=../out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j12 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      SYNC    include/config/auto.conf.cmd
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
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- -j12
[+] Going to build the Linux kernel for arm64
[+] Using "/home/a13x/linux-stable/experiment.config" as kernel config
[+] Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
[+] Using "/home/a13x/linux-stable/build_out" as build output directory
[+] Going to build with: gcc-13
[+] Have additional arguments for 'make': -j12

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
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13 -- -j12
```

### Finishing with the container

That tool is used by `make_linux.py` for fast stopping the kernel build.

Get help:

```console
$ bash ./finish_container.sh
Hey, we gonna use sudo for running docker
usage: ./finish_container.sh kill/nokill out_dir
  kill/nokill -- how to finish: kill the container and then clean up / only clean up
  out_dir -- build output directory used by this container (with container.id file)
```

### Removing created Docker images

```console
$ bash rm_containers.sh
```
