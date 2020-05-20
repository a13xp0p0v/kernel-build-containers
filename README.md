# kernel-build-containers

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

It's very useful for testing gcc-plugins for the Linux kernel, for example.

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

### Running a container

Get help:

```console
$ sh run_container.sh
usage: run_container.sh compiler src_dir out_dir [cmd with args]
  if cmd is empty, we will start an interactive bash in the container
```

Run interactive bash in the container:

```console
$ sh run_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ 
Starting a container with gcc-8
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Gonna run interactive bash...
```

Execute a command in the container:

```console
$ sh run_container.sh gcc-8 ~/linux/linux/ ~/linux/build_out/ gcc -v
Starting a container with gcc-8
Source code directory "/home/a13x/linux/linux/" is mounted at "~/src"
Build output directory "/home/a13x/linux/build_out/" is mounted at "~/out"
Gonna run "gcc -v"
```

### Remove created docker images

```console
$ sh rm_containers.sh
```

