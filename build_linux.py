#!/usr/bin/python3

# pylint: disable=missing-module-docstring,missing-function-docstring

import os
import sys
import argparse
import subprocess
import shutil
import filecmp


supported_archs = ['x86_64', 'i386', 'arm64', 'arm', 'riscv']
supported_compilers = ['clang-5', 'clang-6', 'clang-7', 'clang-8',
                       'clang-9', 'clang-10', 'clang-11', 'clang-12',
                       'clang-13', 'clang-14', 'clang-15', 'clang-16', 'clang-17',
                       'gcc-4.9', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9',
                       'gcc-10', 'gcc-11', 'gcc-12', 'gcc-13', 'gcc-14']

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
    elif arch == 'riscv':
        args_list.append('ARCH=riscv')
        args_list.append('CROSS_COMPILE=riscv64-linux-gnu-')
    return args_list


def finish_building_kernel(out_dir, interrupt):
    print('Finish building the kernel')
    finish_container_cmd = ['bash', os.path.dirname(os.path.abspath(__file__)) + '/finish_container.sh']
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
            print(f'    {line}', end='\r')
        return_code = process.wait()

    print(f'The finish_container.sh script returned {return_code}')


def build_kernel(arch, kconfig, src, out, compiler, make_args):
    print(f'\n=== Building with {compiler} ===')

    if kconfig:
        assert(out), 'output directory is required for building with kconfig file'
        suffix = os.path.splitext(os.path.basename(kconfig))[0]
        out_subdir = out + '/' + suffix + NAME_DELIMITER + arch + NAME_DELIMITER + compiler
    elif not out:
        print('No "-k" and "-o" arguments; skip creating an output subdirectory to allow in-place build')
        out_subdir = src
    elif out == src:
        print('Same "-s" and "-o" values and no "-k"; skip creating an output subdirectory to allow in-place build')
        out_subdir = src
    else:
        out_subdir = out + '/' + arch + NAME_DELIMITER + compiler

    print(f'Output subdirectory for this build: {out_subdir}')
    if os.path.isdir(out_subdir):
        print('Output subdirectory already exists, use it (no cleaning!)')
    else:
        print('Output subdirectory doesn\'t exist, create it')
        os.mkdir(out_subdir)

    if kconfig:
        current_config = out_subdir + '/.config'
        if not os.path.isfile(current_config):
            print(f'No ".config", copy "{kconfig}" to "{current_config}"')
            shutil.copyfile(kconfig, current_config)
        else:
            if filecmp.cmp(kconfig, current_config):
                print(f'kconfig files "{kconfig}" and "{current_config}" are identical, proceed')
            else:
                print(f'kconfig files "{kconfig}" and "{current_config}" differ, stop')
                sys.exit('[!] ERROR: kconfig files are different, check the diff and consider copying')
    else:
        print('No kconfig to copy to output subdirectory')

    start_container_cmd = ['bash', os.path.dirname(os.path.abspath(__file__)) + '/start_container.sh',
                                   compiler, src, out_subdir]

    noninteractive = True
    if 'menuconfig' in make_args:
        noninteractive = False

    if noninteractive:
        start_container_cmd.extend(['-n']) # start container in the non-interactive mode
        build_log = out_subdir + '/build_log.txt'
        print('Going to save build log to "build_log.txt" in output subdirectory')
        build_log_fd = open(build_log, "w", encoding='utf-8')
        stdout_destination = subprocess.PIPE
    else:
        print('Going to run the container in the interactive mode (without build log)')
        stdout_destination = None

    start_container_cmd.extend(['--', 'make'])

    if out_subdir != src:
        start_container_cmd.append('O=../out/')
    else:
        print('Going to build the kernel in-place (without "O=")')

    if compiler.startswith('clang'):
        print('Compiling with clang requires \'CC=clang\'')
        start_container_cmd.extend(['CC=clang'])

    cross_compile_args = get_cross_compile_args(arch)
    if cross_compile_args:
        print(f'Add arguments for cross-compilation: {" ".join(cross_compile_args)}')
    start_container_cmd.extend(cross_compile_args)

    start_container_cmd.extend(make_args)

    print(f'Run the container: {" ".join(start_container_cmd)}')
    interrupt = False
    with subprocess.Popen(start_container_cmd, stdout=stdout_destination, stderr=subprocess.STDOUT,
                          universal_newlines=True, bufsize=1) as process:
        try:
            if noninteractive:
                for line in process.stdout:
                    print(f'    {line}', end='\r')
                    build_log_fd.write(line)
            return_code = process.wait()
            print(f'The container returned {return_code}')
        except KeyboardInterrupt:
            print('[!] Got keyboard interrupt, stopping build process...')
            interrupt = True
    finish_building_kernel(out_subdir, interrupt)
    if noninteractive:
        print(f'See the build log: {build_log}')
        build_log_fd.close()
    if interrupt:
        sys.exit('[!] Exit by interrupt')


def main():
    parser = argparse.ArgumentParser(description='Build Linux kernel using kernel-build-containers')
    parser.add_argument('-k', '--kconfig',
                        help='path to kernel kconfig file (optional argument)')
    parser.add_argument('-a', '--arch', metavar='ARCH', choices=supported_archs, required=True,
                        help=f'build target architecture ({" / ".join(supported_archs)})')
    parser.add_argument('-c', '--compiler', metavar='COMPILER', choices=supported_compilers, required=True,
                        help=f'compiler for building ({" / ".join(supported_compilers)})')
    parser.add_argument('-s', '--src', required=True,
                        help='Linux kernel sources directory')
    parser.add_argument('-o', '--out',
                        help='build output directory, where the output subdirectory "kconfig__arch__compiler" '
                             'is created. Without "-k", the output subdirectory name format is "arch__compiler". '
                             'For in-place building of Linux at the root of the kernel source tree, you can '
                             'specify the same "-s" and "-o" path without "-k" or simply run the tool '
                             'without "-o" and "-k" arguments.')
    parser.add_argument('-q', '--quiet', action='store_true',
                        help='for running `make` in quiet mode')
    parser.add_argument('-t', '--single-thread', action='store_true',
                        help='for running `make` in single-threaded mode (multi-threaded by default)')
    parser.add_argument('make_args', metavar='...', nargs=argparse.REMAINDER,
                        help='additional arguments for \'make\', can be separated by -- delimiter')
    args = parser.parse_args()

    print(f'[+] Going to build the Linux kernel for {args.arch}')

    if args.kconfig:
        if not os.path.isfile(args.kconfig):
            sys.exit(f'[!] ERROR: can\'t find the kernel config "{args.kconfig}"')
        if not args.out:
            sys.exit('[!] ERROR: "-k" requires specifying the build output directory using "-o"')
        print(f'[+] Using "{args.kconfig}" as kernel config')

    print(f'[+] Going to build with: {args.compiler}')

    if not os.path.isdir(args.src):
        sys.exit(f'[!] ERROR: can\'t find the kernel sources directory "{args.src}"')
    print(f'[+] Using "{args.src}" as Linux kernel sources directory')

    if args.out:
        if not os.path.isdir(args.out):
            sys.exit(f'[!] ERROR: can\'t find the build output directory "{args.out}"')
        print(f'[+] Using "{args.out}" as build output directory')

    make_args = args.make_args[:]
    if make_args:
        if make_args[0] == '--':
            make_args.pop(0)
        print(f'[+] Have additional arguments for \'make\': {" ".join(make_args)}')
        for arg in make_args:
            if arg.startswith('O='):
                sys.exit('[-] Don\'t specify "O=", we will take care of that')
            if arg.startswith('ARCH='):
                sys.exit('[-] Don\'t specify "ARCH=", we will take care of that')
            if arg.startswith('CROSS_COMPILE='):
                sys.exit('[-] Don\'t specify "CROSS_COMPILE=", we will take care of that')
            if arg.startswith('CC='):
                sys.exit('[-] Don\'t specify "CC=", we will take care of that')
            if arg.startswith('-j'):
                sys.exit('[-] Don\'t specify "-j", by default we run \'make\' in parallel on all CPUs')

    if args.quiet:
        print('[+] Going to run \'make\' in quiet mode')
        make_args.insert(0, '-s')

    if not args.single_thread:
        cpu_count = os.sysconf('SC_NPROCESSORS_ONLN')
        print(f'[+] Going to run \'make\' on {cpu_count} CPUs')
        make_args = ['-j', str(cpu_count)] + make_args
    else:
        print('[+] Going to run \'make\' in single-threaded mode')

    build_kernel(args.arch, args.kconfig, args.src, args.out, args.compiler, make_args)

    print('\n[+] Done, see the results')


if __name__ == '__main__':
    main()
