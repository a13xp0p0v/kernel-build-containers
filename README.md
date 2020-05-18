# kernel-build-containers

This project provides Docker containers for building the Linux kernel (or other software) with many different compilers.

It's very useful for testing gcc-plugins for the Linux kernel, for example.

Supported gcc versions (with `--enable-plugin`):
 - gcc-4.8
 - gcc-5
 - gcc-6
 - gcc-7
 - gcc-8
 - gcc-9
 - gcc-10

Supported build targets:
 - `x86_64`
 - `i386`
 - `aarch64` (except gcc-4.8)

# Usage

Build all containers:

```bash
$ sh build.sh
```

Run a container (with interactive tty):

```bash
$ sh run.sh
usage: run.sh gcc_version src_dir

$ sh run.sh 7 ~/linux/
```

Remove created docker images:

```bash
$ sh clean.sh
```

# TODO

Add clang
