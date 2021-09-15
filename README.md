# kernel-build-containers

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

It's very useful for testing gcc-plugins for the Linux kernel, for example. Goodbye headache!

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

__Supported clang versions:__
 - clang-12

# Usage

### Building all containers

```console
$ sh build_containers.sh
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
kernel-build-container   clang-12            e181c0783a39        About a minute ago   2.55GB
kernel-build-container   gcc-11              c0180b2255ee        19 minutes ago       2.36GB
kernel-build-container   gcc-10              6856f6b0208a        24 minutes ago       1.17GB
kernel-build-container   gcc-9               1a3e47ac817c        28 minutes ago       737MB
kernel-build-container   gcc-8               68d7e5eb2719        30 minutes ago       1.03GB
kernel-build-container   gcc-7               4366b8a2dc87        33 minutes ago       649MB
kernel-build-container   gcc-6               7944ac6e862f        36 minutes ago       901MB
kernel-build-container   gcc-5               9008f7e6b369        39 minutes ago       658MB
kernel-build-container   gcc-4.9             16ccdc6b913b        41 minutes ago       851MB
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
usage: make_linux.py [-h] -a {x86_64,i386,aarch64} [-k kconfig] -s src -o out -c
                     {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,clang-12,all}
                     ...

Build Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by -- delimiter

optional arguments:
  -h, --help            show this help message and exit
  -a {x86_64,i386,aarch64}
                        build target architecture
  -k kconfig            path to kernel kconfig file
  -s src                Linux kernel sources directory
  -o out                Build output directory
  -c {gcc-4.9,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,clang-12,all}
                        building compiler ('all' to build with each of them)
```

Kernel building example:

```console
$ python3 make_linux.py -a aarch64 -k ~/linux/experiment.config -s ~/linux/linux -o ~/linux/build_out -c clang-12 -- -j5
[+] Going to build the Linux kernel for aarch64
[+] Using "/home/a13x/linux/experiment.config" as kernel config
[+] Using "/home/a13x/linux/linux" as Linux kernel sources directory
[+] Using "/home/a13x/linux/build_out" as build output directory
[+] Going to build with: clang-12
[+] Have additional arguments for 'make': -j5

=== Building with clang-12 ===
Output subdirectory for this build: /home/a13x/linux/build_out/experiment__aarch64__clang-12
Output subdirectory already exists, use it (no cleaning!)
Copy kconfig to output subdirectory as ".config"
Going to save build log to "build_log.txt" in output subdirectory
Compiling with clang requires 'CC=clang'
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh clang-12 /home/a13x/linux/linux /home/a13x/linux/build_out/experiment__aarch64__clang-12 -n make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:clang-12"
    Source code directory "/home/a13x/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/linux/build_out/experiment__aarch64__clang-12" is mounted at "~/out"
    Run docker in NON-interactive mode
    Gonna run "make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      SYNC    include/config/auto.conf.cmd
      GEN     Makefile
...
    make[1]: Leaving directory '/home/a13x/out'
The container returned 0
See build log: /home/a13x/linux/build_out/experiment__aarch64__clang-12/build_log.txt
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/linux/build_out/experiment__aarch64__clang-12"
    OK, "container.id" file exists, removing it
    OK, container 48a25a340a1ceb3d1ee4baa4eafb1b44ad98c6a70bd105f0376cffb2ba21bd2e doesn't run
Finished with the container

[+] Done, see the results
```

### Finishing with the container

That tool is used by `make_linux.py` for fast stopping the kernel build.

Get help:

```console
usage: ./finish_container.sh kill/nokill out_dir
  kill/nokill -- what to do with this container
  out_dir -- build output directory used by this container (with container.id file)
```

### Removing created Docker images

```console
$ sh rm_containers.sh
```

