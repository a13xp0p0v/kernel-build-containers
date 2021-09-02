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
 - gcc-11

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
kernel-build-container   gcc-11              aff1d980db1f        15 minutes ago      1.53GB
kernel-build-container   gcc-10              923481cb3d94        2 months ago        852MB
kernel-build-container   gcc-9               a15605755586        2 months ago        561MB
kernel-build-container   gcc-8               44a10601240d        2 months ago        764MB
kernel-build-container   gcc-7               f6fa0a1ece58        2 months ago        519MB
kernel-build-container   gcc-6               242af7de9933        2 months ago        692MB
kernel-build-container   gcc-5               ba9cd1de31f5        2 months ago        545MB
kernel-build-container   gcc-4.8             5948f3cd8839        2 months ago        664MB
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
$ sh start_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ 
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-8"
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Gonna run interactive bash...
```

Execute a command in the container:

```console
$ sh start_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ gcc -v
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
                     {gcc-4.8,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,all}
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
  -c {gcc-4.8,gcc-5,gcc-6,gcc-7,gcc-8,gcc-9,gcc-10,gcc-11,all}
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
Run the container: bash ./start_container.sh gcc-8 /home/a13x/linux/linux /home/a13x/linux/build_out/experiment__aarch64__gcc-8 -n make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:gcc-8"
    Source code directory "/home/a13x/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/linux/build_out/experiment__aarch64__gcc-8" is mounted at "~/out"
    Run docker in NON-interactive mode
    Gonna run "make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      GEN     Makefile
      HOSTCC  scripts/basic/fixdep
      HOSTCC  scripts/kconfig/conf.o
...
Running the container returned 0
See build log: /home/a13x/linux/build_out/experiment__aarch64__gcc-8/build_log.txt

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

