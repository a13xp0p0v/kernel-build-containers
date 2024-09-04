#!/usr/bin/python3

# pylint: disable=missing-module-docstring,missing-function-docstring

import os
import sys
import argparse
import subprocess
import shutil
import filecmp


supported_archs = ['x86_64', 'i386', 'arm64', 'arm', 'powerpc']
supported_compilers = ['gcc-4.9', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9', 'gcc-10', 'gcc-11', 'gcc-12', 'gcc-13', 'gcc-14',
                       'clang-12', 'clang-13', 'clang-14', 'clang-15', 'clang-16', 'clang-17',
                       'all']

NAME_DELIMITER = '__'


def get_cross_compile_args(arch):
    args_list = []
    if arch == 'i386':
        args_list.append('ARCH=i386')
    elif arch == 'arm64':
        args_list.append('ARCH=arm64')
        args_list.append('CROSS_COMPILE=aarch64-linux-gnu-')
    elif arch == 'arm':
        args_list.append('ARCH=arm')
        args_list.append('CROSS_COMPILE=arm-linux-gnueabi-')
    elif arch == 'powerpc':
        args_list.append('ARCH=powerpc')
        args_list.append('CROSS_COMPILE=powerpc64le-linux-gnu-')
    return args_list


def finish_building_kernel(out_dir, interrupt):
    print('Finish building the kernel')
    finish_container_cmd = ['bash', './finish_container.sh']
    if interrupt:
        print('Kill the container and remove the container id file:')
        finish_container_cmd.extend(['kill'])
    else:
        print('Only remove the container id file:')
        finish_container_cmd.extend(['nokill'])
    finish_container_cmd.extend([out_dir])

    with subprocess.Popen(finish_container_cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True, bufsize=1) as process:
        for line in process.stdout:
            print('    {}'.format(line), end='\r')
        return_code = process.wait()

    print('The finish_container.sh script returned {}'.format(return_code))


def build_kernel(arch, kconfig, src, out, compiler, make_args):
    print('\n=== Building with {} ==='.format(compiler))

    if kconfig:
        suffix = os.path.splitext(os.path.basename(kconfig))[0]
        if arch in suffix:
            print('Arch name "{}" is already a part of kconfig name'.format(arch))
            out_subdir = out + '/' + suffix + NAME_DELIMITER + compiler
        else:
            out_subdir = out + '/' + suffix + NAME_DELIMITER + arch + NAME_DELIMITER + compiler
    else:
            out_subdir = out + '/' + arch + NAME_DELIMITER + compiler

    print('Output subdirectory for this build: {}'.format(out_subdir))
    if os.path.isdir(out_subdir):
        print('Output subdirectory already exists, use it (no cleaning!)')
    else:
        print('Output subdirectory doesn\'t exist, create it')
        os.mkdir(out_subdir)

    if kconfig:
        current_config = out_subdir + '/.config'
        if not os.path.isfile(current_config):
            print('No ".config", copy "{}" to "{}"'.format(kconfig, current_config))
            shutil.copyfile(kconfig, current_config)
        else:
            if filecmp.cmp(kconfig, current_config):
                print('kconfig files "{}" and "{}" are identical, proceed'.format(kconfig, current_config))
            else:
                print('kconfig files "{}" and "{}" differ, stop'.format(kconfig, current_config))
                sys.exit('[!] ERROR: kconfig files are different, check the diff and consider copying')
    else:
        print('No kconfig to copy to output subdirectory')

    start_container_cmd = ['bash', './start_container.sh', compiler, src, out_subdir]

    noninteractive = True
    if 'menuconfig' in make_args:
        noninteractive = False

    if noninteractive:
        start_container_cmd.extend(['-n']) # start container in the non-interactive mode
        build_log = out_subdir + '/build_log.txt'
        print('Going to save build log to "build_log.txt" in output subdirectory')
        build_log_fd = open(build_log, "w")
        stdout_destination = subprocess.PIPE
    else:
        print('Going to run the container in the interactive mode (without build log)')
        stdout_destination = None

    start_container_cmd.extend(['--', 'make', 'O=../out/'])

    if compiler.startswith('clang'):
        print('Compiling with clang requires \'CC=clang\'')
        start_container_cmd.extend(['CC=clang'])

    cross_compile_args = get_cross_compile_args(arch)
    if cross_compile_args:
        print('Add arguments for cross-compilation: {}'.format(' '.join(cross_compile_args)))
    start_container_cmd.extend(cross_compile_args)

    start_container_cmd.extend(make_args)

    if noninteractive:
        start_container_cmd.extend(['2>&1'])

    print('Run the container: {}'.format(' '.join(start_container_cmd)))
    interrupt = False
    with subprocess.Popen(start_container_cmd, stdout=stdout_destination, stderr=subprocess.STDOUT,
                          universal_newlines=True, bufsize=1) as process:
        try:
            if noninteractive:
                for line in process.stdout:
                    print('    {}'.format(line), end='\r')
                    build_log_fd.write(line)
            return_code = process.wait()
            print('The container returned {}'.format(return_code))
        except KeyboardInterrupt:
            print('[!] Got keyboard interrupt, stopping build process...')
            interrupt = True
    finish_building_kernel(out_subdir, interrupt)
    if noninteractive:
        print('See the build log: {}'.format(build_log))
        build_log_fd.close()
    if interrupt:
        sys.exit('[!] Exit by interrupt')


def build_kernels(arch, kconfig, src, out, compilers, make_args):
    for compiler in compilers:
        build_kernel(arch, kconfig, src, out, compiler, make_args)


def main():
    parser = argparse.ArgumentParser(description='Build Linux kernel using kernel-build-containers')
    parser.add_argument('-a', choices=supported_archs, required=True,
                        help='build target architecture')
    parser.add_argument('-k', metavar='kconfig',
                        help='path to kernel kconfig file')
    parser.add_argument('-s', metavar='src', required=True,
                        help='Linux kernel sources directory')
    parser.add_argument('-o', metavar='out', required=True,
                        help='build output directory')
    parser.add_argument('-c', choices=supported_compilers, required=True,
                        help='building compiler (\'all\' to build with each of them)')
    parser.add_argument('make_args', metavar='...', nargs=argparse.REMAINDER,
                        help='additional arguments for \'make\', can be separated by -- delimiter')
    args = parser.parse_args()

    print('[+] Going to build the Linux kernel for {}'.format(args.a))

    if args.k:
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
    if make_args:
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
            if arg.startswith('CC='):
                sys.exit('[-] Don\'t specify "CC=", we will take care of that')

    build_kernels(args.a, args.k, args.s, args.o, compilers, make_args)

    print('\n[+] Done, see the results')


if __name__ == '__main__':
    main()
