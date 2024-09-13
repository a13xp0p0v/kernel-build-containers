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

## Usage

### Building all containers

```console
$ bash build_containers.sh
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
kernel-build-container   clang-17   c24d2754f36d   About a minute ago   6.01GB
kernel-build-container   clang-16   9b3f7dce5f5b   12 minutes ago       6.01GB
kernel-build-container   clang-15   9f62c82c4826   24 minutes ago       3.83GB
kernel-build-container   clang-14   83523b7c7241   41 minutes ago       2.21GB
kernel-build-container   clang-13   8c0f0e68075a   46 minutes ago       2.27GB
kernel-build-container   clang-12   ac2cea3e0e97   51 minutes ago       2.21GB
kernel-build-container   gcc-14     ff56932d9a3e   7 hours ago          4.36GB
kernel-build-container   gcc-13     b05623469193   7 hours ago          3.14GB
kernel-build-container   gcc-12     63562d1fbb5e   7 hours ago          1.55GB
kernel-build-container   gcc-11     c4b2e14874f2   7 hours ago          1.03GB
kernel-build-container   gcc-10     bcbfb78c4a6c   7 hours ago          1.27GB
kernel-build-container   gcc-9      76f580f18759   7 hours ago          833MB
kernel-build-container   gcc-8      e22bee633dff   8 hours ago          1.12GB
kernel-build-container   gcc-7      e79708f81b84   8 hours ago          740MB
kernel-build-container   gcc-6      61f40d3e3e58   8 hours ago          992MB
kernel-build-container   gcc-5      ed6270a767c6   8 hours ago          720MB
kernel-build-container   gcc-4.9    408db89527ec   8 hours ago          913MB
```

### Building containers with manage_containers.py:

Get help:

```console
$ python manage_containers.py -h
usage: manage_containers.py [-h] [-l] [-a compiler] [-r] [-q]

Manage the kernel-build-containers

options:
  -h, --help            show this help message and exit
  -l, --list            show the kernel build containers
  -a compiler, --add compiler
                        build a container with: (gcc-4.9, gcc-5, gcc-6, gcc-7, gcc-8, gcc-9, gcc-10, gcc-11, gcc-12, gcc-13, gcc-14, clang-5, clang-6, clang-7, clang-8, clang-9,
                        clang-10, clang-11, clang-12, clang-13, clang-14, clang-15, clang-16, clang-17, all,where 'all' for all of the compilers)
  -r, --remove          remove all created containers
  -q, --quiet           suppress container build output
```

Building all containers:

```console
$ python3 manage_containers.py -a all
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
REPOSITORY               TAG         IMAGE ID       CREATED          SIZE
kernel-build-container   clang-17    f82a39f4f536   10 seconds ago   4.87GB
kernel-build-container   gcc-14      f82a39f4f536   10 seconds ago   4.87GB
kernel-build-container   clang-16    debeffa0b306   2 minutes ago    4.89GB
kernel-build-container   clang-15    282ee1c70ef4   5 minutes ago    3.49GB
kernel-build-container   gcc-13      282ee1c70ef4   5 minutes ago    3.49GB
kernel-build-container   clang-14    65e5a9bfec0f   7 minutes ago    1.88GB
kernel-build-container   gcc-12      65e5a9bfec0f   7 minutes ago    1.88GB
kernel-build-container   clang-13    57e0584fe0d3   12 minutes ago   1.96GB
kernel-build-container   clang-12    fbb06aca13c9   13 minutes ago   1.71GB
kernel-build-container   gcc-11      fbb06aca13c9   13 minutes ago   1.71GB
kernel-build-container   clang-11    b3a75c3fd9ad   14 minutes ago   1.62GB
kernel-build-container   gcc-10      b3a75c3fd9ad   14 minutes ago   1.62GB
kernel-build-container   clang-10    6401372cf5aa   15 minutes ago   1.39GB
kernel-build-container   gcc-9       6401372cf5aa   15 minutes ago   1.39GB
kernel-build-container   clang-9     6668ffd11788   17 minutes ago   1.55GB
kernel-build-container   gcc-8       6668ffd11788   17 minutes ago   1.55GB
kernel-build-container   clang-8     23935b3308af   18 minutes ago   1.4GB
kernel-build-container   gcc-7       23935b3308af   18 minutes ago   1.4GB
kernel-build-container   clang-7     a9cc66b33f3e   19 minutes ago   1.5GB
kernel-build-container   gcc-6       a9cc66b33f3e   19 minutes ago   1.5GB
kernel-build-container   clang-6     8485509afe41   21 minutes ago   1.33GB
kernel-build-container   gcc-5       8485509afe41   21 minutes ago   1.33GB
kernel-build-container   clang-5     939c94215f80   22 minutes ago   1.87GB
kernel-build-container   gcc-4.9     939c94215f80   22 minutes ago   1.87GB
```

Building all containers quietly:

```console
$ python3 manage_containers.py -a all -q
```

last part of expected output:

```console
Ubuntu | GCC    | Clang  | Status
----------------------------------
16.04  | 4.9    | 5      | [+]   
16.04  | 5      | 6      | [+]   
18.04  | 6      | 7      | [+]   
18.04  | 7      | 8      | [+]   
20.04  | 8      | 9      | [+]   
20.04  | 9      | 10     | [+]   
20.04  | 10     | 11     | [+]   
22.04  | 11     | 12     | [+]   
22.04  | 12     | 13     | [+]   
22.04  | 12     | 14     | [+]   
23.04  | 13     | 15     | [+]   
24.04  | 14     | 16     | [+]   
24.04  | 14     | 17     | [+] 
```

Building the specified container:

```console
$ python3 manage_containers.py -a clang-10
```

Building the specified container quietly:

```console
$ python manage_containers.py -a clang-10 -q
```

expected output:

```console
We need to use sudo to run the Docker
Adding Ubuntu-20.04 container with GCC-9 and Clang-10
sha256:cc53be032fc2e7ed3942cf399c68e3bc91284d3362a280673afd94be4b2455b5

Ubuntu | GCC    | Clang  | Status
----------------------------------
16.04  | 4.9    | 5      | [-]   
16.04  | 5      | 6      | [-]   
18.04  | 6      | 7      | [-]   
18.04  | 7      | 8      | [-]   
20.04  | 8      | 9      | [-]   
20.04  | 9      | 10     | [+]   
20.04  | 10     | 11     | [-]   
22.04  | 11     | 12     | [-]   
22.04  | 12     | 13     | [-]   
22.04  | 12     | 14     | [-]   
23.04  | 13     | 15     | [-]   
24.04  | 14     | 16     | [-]   
24.04  | 14     | 17     | [-]
```

### Running a container

Get help:

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

### Building the Linux kernel

Get help:

```console
$ python3 make_linux.py --help
usage: make_linux.py [-h] -c {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,gcc-13,gcc-14,
                     clang-12,clang-13,clang-14,clang-15,clang-16,clang-17,all} -a {x86_64,i386,arm64,arm}
                     -s src -o out [-k kconfig] [-q] [-t]
                     ...

Build the Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by -- delimiter

options:
  -h, --help            show this help message and exit
  -c {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,gcc-12,gcc-13,gcc-14,
      clang-12,clang-13,clang-14,clang-15,clang-16,clang-17,all}
                        building compiler ('all' to build with each of them)
  -a {x86_64,i386,arm64,arm}
                        build target architecture
  -s src                Linux kernel sources directory
  -o out                build output directory
  -k kconfig            path to kernel kconfig file
  -q                    for running `make` in quiet mode
  -t                    for running `make` in single-threaded mode (multi-threaded by default)
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

Build the Linux kernel in the needed container:

```console
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
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
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
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
$ python3 make_linux.py -a arm64 -k ~/linux-stable/experiment.config -s ~/linux-stable/linux-stable -o ~/linux-stable/build_out -c gcc-13
```

### Finishing with the container

That tool is used by `make_linux.py` for fast stopping the kernel build.

Get help:

```console
$ bash finish_container.sh
Hey, we gonna use sudo for running docker
usage: finish_container.sh kill/nokill out_dir
  kill/nokill -- how to finish: kill the container and then clean up / only clean up
  out_dir -- build output directory used by this container (with container.id file)
```

### Removing created Docker images

```console
$ bash rm_containers.sh
```

### Removing created Docker images (manage_containers.py alternative with warning for running containers):

```console
$ python3 manage_containers.py -r
```

last part of expected output without running containers:

```console
$ python manage_containers.py -r
We need to use sudo to run the Docker

Ubuntu | GCC    | Clang  | Status
----------------------------------
16.04  | 4.9    | 5      | [-]   
16.04  | 5      | 6      | [-]   
18.04  | 6      | 7      | [-]   
18.04  | 7      | 8      | [-]   
20.04  | 8      | 9      | [-]   
20.04  | 9      | 10     | [-]   
20.04  | 10     | 11     | [-]   
22.04  | 11     | 12     | [-]   
22.04  | 12     | 13     | [-]   
22.04  | 12     | 14     | [-]   
23.04  | 13     | 15     | [-]   
24.04  | 14     | 16     | [-]   
24.04  | 14     | 17     | [-]
```

last part of expected output with running clang-12 container:
```consoler
You still have running containers, that can't be removed:
 148254296e5d   kernel-build-container:clang-12   "/bin/bash"   14 seconds ago   Up 14 seconds             determined_grothendieck


Ubuntu | GCC    | Clang  | Status
----------------------------------
16.04  | 4.9    | 5      | [-]   
16.04  | 5      | 6      | [-]   
18.04  | 6      | 7      | [-]   
18.04  | 7      | 8      | [-]   
20.04  | 8      | 9      | [-]   
20.04  | 9      | 10     | [-]   
20.04  | 10     | 11     | [-]   
22.04  | 11     | 12     | [+]   
22.04  | 12     | 13     | [-]   
22.04  | 12     | 14     | [-]   
23.04  | 13     | 15     | [-]   
24.04  | 14     | 16     | [-]   
24.04  | 14     | 17     | [-]
```

### Running tets for manage_containers.py:

```console
$ bash cov.sh
```

Results will be stored in htmlcov/index.html
