# kernel-build-containers

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

It's very useful for testing gcc-plugins for the Linux kernel, for example. Goodbye headache!

__Supported gcc versions:__
 - gcc-4.8
 - gcc-5
 - gcc-6
 - gcc-7
 - gcc-8
 - gcc-9
 - gcc-10

__Supported build targets:__
 - `x86_64`
 - `i386`
 - `aarch64`

__Exception:__ `gcc-4.8` for `aarch64` doesn't support `gcc-plugins`.

__Idea for future:__ add Clang.

# Usage

### Building all containers

```console
$ sh build_containers.sh
```

Created containers:

```console
$ sudo docker image list | grep kernel-build-container
kernel-build-container   gcc-10              fab3a069196e        32 hours ago        846MB
kernel-build-container   gcc-9               d1b4c1b033e7        32 hours ago        558MB
kernel-build-container   gcc-8               28312dbbe158        32 hours ago        761MB
kernel-build-container   gcc-7               06df61161fbd        32 hours ago        518MB
kernel-build-container   gcc-6               7672ffd9b861        33 hours ago        691MB
kernel-build-container   gcc-5               e6f4e6385f9a        33 hours ago        535MB
kernel-build-container   gcc-4.8             bf3afaccb668        33 hours ago        654MB
```

### Running a container

Get help:

```console
$ sh run_container.sh
usage: run_container.sh compiler src_dir out_dir [-n] [cmd with args]
  use '-n' for non-interactive session
  if cmd is empty, we will start an interactive bash in the container
```

Run interactive bash in the container:

```console
$ sh run_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ 
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-8"
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Gonna run interactive bash...
```

Execute a command in the container:

```console
$ sh run_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ gcc -v
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-8"
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Gonna run "gcc -v"
```

### Building Linux kernel

Get help:

```console
$ python3 make_linux.py -h
usage: make_linux.py [-h] -a {x86_64,i386,aarch64} -k kconfig -s src -o out -c
                     {gcc-4.8,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,all}
                     ...

Build Linux kernel using kernel-build-containers

positional arguments:
  ...                   additional arguments for 'make', can be separated by
                        '--' delimeter

optional arguments:
  -h, --help            show this help message and exit
  -a {x86_64,i386,aarch64}
                        build target architecture
  -k kconfig            path to kernel kconfig file
  -s src                Linux kernel sources directory
  -o out                Build output directory
  -c {gcc-4.8,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,all}
                        building compiler ('all' to build with each of them)
```

Kernel building example:

```console
$ python3 make_linux.py -a aarch64 -k ~/linux/experiment.config -s ~/linux/linux -o ~/linux/build_out -c gcc-8 -- -j5
[+] Going to build the Linux kernel for aarch64
[+] Using "/home/a13x/linux/experiment.config" as kernel config
[+] Using "/home/a13x/linux/linux" as Linux kernel sources directory
[+] Using "/home/a13x/linux/build_out" as build output directory
[+] Going to build with: gcc-8
[+] Have additional arguments for 'make': -j5

=== Building with gcc-8 ===
Output subdirectory for this build: /home/a13x/linux/build_out/experiment__aarch64__gcc-8
Output subdirectory doesn't exist, create it
Copy kconfig to output subdirectory as ".config"
Going to save build log to "build_log.txt" in output subdirectory
Create additional arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./run_container.sh gcc-8 /home/a13x/linux/linux /home/a13x/linux/build_out/experiment__aarch64__gcc-8 make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1 | tee ~/out/build_log.txt
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:gcc-8"
    Source code directory "/home/a13x/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/linux/build_out/experiment__aarch64__gcc-8" is mounted at "~/out"
    Gonna run "make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1 | tee ~/out/build_log.txt"
    
    make[1]: Entering directory '/home/a13x/out'
      GEN     Makefile
      HOSTCC  scripts/basic/fixdep
      HOSTCC  scripts/kconfig/conf.o
...
Running the container returned 0
See build log: /home/a13x/linux/build_out/experiment__aarch64__gcc-8/build_log.txt

[+] Done, see the results
```

### Removing created Docker images

```console
$ sh rm_containers.sh
```

