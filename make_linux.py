#!/usr/bin/python3

import os
import sys
import argparse
import subprocess
import shutil


supported_archs = ['x86_64', 'i386', 'aarch64']
supported_compilers = ['gcc-4.8', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9', 'gcc-10', 'all']

name_delimiter = '__'


def get_cross_compile_args(arch):
    if arch == 'x86_64':
        return []
    if arch == 'i386':
        return ['ARCH=i386']
    if arch == 'aarch64':
        return ['ARCH=arm64', 'CROSS_COMPILE=aarch64-linux-gnu-']


def build_kernel(arch, kconfig, src, out, compiler, make_args):
    print('\n=== Building with {} ==='.format(compiler))

    suffix = os.path.splitext(os.path.basename(kconfig))[0]

    if arch in suffix:
        print('Arch name "{}" is already a part of kconfig name'.format(arch))
        out_subdir = out + '/' + suffix + name_delimiter + compiler
    else:
        out_subdir = out + '/' + suffix + name_delimiter + arch + name_delimiter + compiler

    print('Output subdirectory for this build: {}'.format(out_subdir))
    if os.path.isdir(out_subdir):
        print('Output subdirectory already exists, use it (no cleaning!)')
    else:
        print('Output subdirectory doesn\'t exist, create it')
        os.mkdir(out_subdir)

    print('Copy kconfig to output subdirectory as ".config"')
    shutil.copyfile(kconfig, out_subdir + '/.config')

    build_log = out_subdir + '/build_log.txt'
    print('Going to save build log to "build_log.txt" in output subdirectory')
    build_log_fd = open(build_log, "w")

    start_container_cmd = ['bash', './start_container.sh', compiler, src, out_subdir, '-n', 'make', 'O=~/out/']

    cross_compile_args = get_cross_compile_args(arch)
    if cross_compile_args:
        print("Create additional arguments for cross-compilation: {}".format(' '.join(cross_compile_args)))
    start_container_cmd.extend(cross_compile_args)

    start_container_cmd.extend(make_args)

    start_container_cmd.extend(['2>&1'])

    print('Run the container: {}'.format(' '.join(start_container_cmd)))
    with subprocess.Popen(start_container_cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True, bufsize=1) as process:
        for line in process.stdout:
            print('    {}'.format(line), end='\r')
            build_log_fd.write(line)
        return_code = process.wait()
        print('Running the container returned {}'.format(return_code))
    print('See build log: {}'.format(build_log))
    build_log_fd.close()


def build_kernels(arch, kconfig, src, out, compilers, make_args):
    for compiler in compilers:
        build_kernel(arch, kconfig, src, out, compiler, make_args)


def main():
    parser = argparse.ArgumentParser(description='Build Linux kernel using kernel-build-containers')
    parser.add_argument('-a', choices=supported_archs, required=True,
                        help='build target architecture')
    parser.add_argument('-k', metavar='kconfig', required=True,
                        help='path to kernel kconfig file')
    parser.add_argument('-s', metavar='src', required=True,
                        help='Linux kernel sources directory')
    parser.add_argument('-o', metavar='out', required=True,
                        help='Build output directory')
    parser.add_argument('-c', choices=supported_compilers, required=True,
                        help='building compiler (\'all\' to build with each of them)')
    parser.add_argument('make_args', metavar='...', nargs=argparse.REMAINDER,
                        help='additional arguments for \'make\', can be separated by \'--\' delimeter')
    args = parser.parse_args()

    print('[+] Going to build the Linux kernel for {}'.format(args.a))

    if not os.path.isfile(args.k):
        sys.exit('[!] ERROR: can\'t find the kernel config "{}"'.format(args.k))
    print('[+] Using "{}" as kernel config'.format(args.k))

    if not os.path.isdir(args.s):
        sys.exit('[!] ERROR: can\'t find the kernel sources directory "{}"'.format(args.s))
    print('[+] Using "{}" as Linux kernel sources directory'.format(args.s))

    if not os.path.isdir(args.o):
        sys.exit('[!] ERROR: can\'t find the build output directory "{}"'.format(args.o))
    print('[+] Using "{}" as build output directory'.format(args.o))

    compilers = []
    if args.c != 'all':
        compilers.append(args.c)
    else:
        compilers = supported_compilers[:]
        compilers.remove('all')
    print('[+] Going to build with: {}'.format(' '.join(compilers)))

    make_args = args.make_args[:]
    if len(make_args):
        if make_args[0] == '--':
            make_args.pop(0)
        print('[+] Have additional arguments for \'make\': {}'.format(' '.join(make_args)))
        for arg in make_args:
            if arg.startswith('O='):
                sys.exit('[-] Don\'t specify "O=", we will take care of that')
            if arg.startswith('ARCH='):
                sys.exit('[-] Don\'t specify "ARCH=", we will take care of that')
            if arg.startswith('CROSS_COMPILE='):
                sys.exit('[-] Don\'t specify "CROSS_COMPILE=", we will take care of that')

    build_kernels(args.a, args.k, args.s, args.o, compilers, make_args)

    print('\n[+] Done, see the results')


if __name__ == '__main__':
    main()
