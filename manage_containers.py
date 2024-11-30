#!/usr/bin/python3

"""
This tool manages containers for building the Linux kernel with various compilers
"""

import os
import subprocess
import sys
import argparse
import re
import pwd
import grp

supported_compilers = ['clang-5', 'clang-6', 'clang-7', 'clang-8',
                       'clang-9', 'clang-10', 'clang-11', 'clang-12',
                       'clang-13', 'clang-14', 'clang-15', 'clang-16', 'clang-17',
                       'gcc-4.9', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9',
                       'gcc-10', 'gcc-11', 'gcc-12', 'gcc-13', 'gcc-14',
                       'all']

class Container:
    """
    Represents a container for building the Linux kernel with a specified compiler

    Class Attributes:
        runtime_cmd (List): commands for calling the container runtime
        quiet (bool): quiet mode for hiding the container build log

    Instance Attributes:
        clang (str): Clang version
        clang_tag (str): container Clang tag
        gcc (str): GCC version
        gcc_tag (str): container GCC tag
        ubuntu (str): Ubuntu version
        id (str): container ID
    """

    runtime_cmd = None
    quiet = False

    def __init__(self, clang_version, gcc_version, ubuntu_version):
        if not Container.runtime_cmd:
            Container.runtime_cmd = self.identify_runtime_cmd()
        self.clang = clang_version
        self.clang_tag = 'kernel-build-container:clang-' + self.clang
        self.gcc = gcc_version
        self.gcc_tag = 'kernel-build-container:gcc-' + self.gcc
        self.ubuntu = ubuntu_version
        self.check()

    def add(self):
        """Build a container that provides the specified compilers"""
        build_args = ['build',
                      '--build-arg', f'CLANG_VERSION={self.clang}',
                      '--build-arg', f'GCC_VERSION={self.gcc}',
                      '--build-arg', f'UBUNTU_VERSION={self.ubuntu}',
                      '--build-arg', f'UNAME={pwd.getpwuid(os.getuid())[0]}',
                      '--build-arg', f'GNAME={grp.getgrgid(os.getgid())[0]}',
                      '--build-arg', f'UID={os.getuid()}',
                      '--build-arg', f'GID={os.getgid()}',
                      '-t', self.clang_tag,
                      '-t', self.gcc_tag]
        build_dir = ['.']
        if self.quiet:
            print('Quiet mode, please wait...')
            build_args += ['-q']
        cmd = self.runtime_cmd + build_args + build_dir
        subprocess.run(cmd, text=True, check=True)
        self.check()

    def rm(self):
        """Remove the container if it exists and is not running"""
        cmd = self.runtime_cmd + ['ps']
        out = subprocess.run(cmd, text=True, check=True, stdout=subprocess.PIPE).stdout
        find = rf'({self.clang_tag}|{self.gcc_tag})'
        running = re.findall(find, out)
        if not running:
            cmd = self.runtime_cmd + ['rmi', '-f', self.id]
            subprocess.run(cmd, text=True, check=True)
            self.check()
            return ''
        return ''.join(running)

    def check(self):
        """Check whether the container exists and get its image ID"""
        check_clang_cmd = self.runtime_cmd + ['images', self.clang_tag, '--format', '{{.ID}}']
        clang_id = subprocess.run(check_clang_cmd, text=True, check=True, stdout=subprocess.PIPE).stdout.strip()
        if clang_id:
            check_gcc_cmd = self.runtime_cmd + ['images', self.gcc_tag, '--format', '{{.ID}}']
            gcc_id = subprocess.run(check_gcc_cmd, text=True, check=True, stdout=subprocess.PIPE).stdout.strip()
            # gcc_id may differ from clang_id if it's overridden by another container
            if not gcc_id:
                sys.exit(f'[!] ERROR: invalid container "{self.clang_tag}" without "{self.gcc_tag}", remove it manually')
        self.id = clang_id

    def identify_runtime_cmd(self):
        """Identify the commands for working with the container runtime"""
        try:
            cmd = ['docker', 'ps']
            out = subprocess.run(cmd, text=True, check=False, capture_output=True)
            if out.returncode == 0:
                return ['docker']
            if 'permission denied' in out.stderr:
                print('We need "sudo" for working with containers')
                return ['sudo', 'docker']
            sys.exit(f'[!] ERROR: testing "{" ".join(cmd)}" gives unknown error:\n{out.stderr}')
        except FileNotFoundError:
            sys.exit('[!] ERROR: the container runtime is not installed')

def add_containers(needed_compiler, containers):
    """Add container(s) with the specified compiler"""
    for c in containers:
        if needed_compiler == 'all':
            print(f'Adding Ubuntu-{c.ubuntu} container with Clang-{c.clang} and GCC-{c.gcc}')
            if not c.id:
                c.add()
            else:
                print('[!] WARNING: exists, skipping!')
        if needed_compiler in ('clang-' + c.clang, 'gcc-' + c.gcc):
            if c.id:
                sys.exit(f'[!] ERROR: container with {needed_compiler} already exists!')
            print(f'Adding Ubuntu-{c.ubuntu} container with Clang-{c.clang} and GCC-{c.gcc}')
            c.add()
            return

def remove_containers(containers):
    """Remove the container images"""
    out = ''
    for c in containers:
        if c.id:
            print(f'Removing Ubuntu-{c.ubuntu} container with Clang-{c.clang} and GCC-{c.gcc}')
            out = out + '\n' + c.rm()
    if out:
        print('\nYou still have running containers, that can\'t be removed:\n'+out)

def list_containers(containers):
    """Show the containers and their IDs"""
    print('-' * 41)
    print(f' {"Ubuntu":<6} | {"Clang":<6} | {"GCC":<6} | {"Container ID"}')
    print('-' * 41)
    for c in containers:
        print(f' {c.ubuntu:<6} | {c.clang:<6} | {c.gcc:<6} | {c.id if c.id else "-"}')

def main():
    """The main function for managing the kernel-build-containers"""
    parser = argparse.ArgumentParser(description='Manage the kernel-build-containers')
    parser.add_argument('-l','--list', action='store_true',
                        help='show the containers and their IDs')
    parser.add_argument('-a', '--add', choices=supported_compilers, metavar='compiler',
                        help=f'add a container with {" / ".join(supported_compilers)} '
                              '(use "all" for adding all containers)')
    parser.add_argument('-q','--quiet', action='store_true',
                        help='suppress the container build output (for using with --add)')
    parser.add_argument('-r', '--remove', action='store_true',
                        help='remove all created containers')
    args = parser.parse_args()

    if not any((args.list, args.add, args.remove)):
        parser.print_help()
        sys.exit(1)
    if bool(args.list) + bool(args.add) + bool(args.remove) > 1:
        sys.exit('[!] ERROR: combining these options doesn\'t make sense!')

    containers = []
    containers += [Container('5', '4.9', '16.04')]
    containers += [Container('6', '5', '16.04')]
    containers += [Container('7', '6', '18.04')]
    containers += [Container('8', '7', '18.04')]
    containers += [Container('9', '8', '20.04')]
    containers += [Container('10', '9', '20.04')]
    containers += [Container('11', '10', '20.04')]
    containers += [Container('12', '11', '22.04')]
    containers += [Container('13', '12', '22.04')]
    containers += [Container('14', '12', '22.04')]
    containers += [Container('15', '13', '23.04')]
    containers += [Container('16', '14', '24.04')]
    containers += [Container('17', '14', '24.04')]

    if args.quiet:
        Container.quiet = True

    if args.list:
        list_containers(containers)
        sys.exit(0)

    if args.add:
        add_containers(args.add, containers)
        list_containers(containers)
        sys.exit(0)

    if args.remove:
        remove_containers(containers)
        list_containers(containers)
        sys.exit(0)

if __name__ == '__main__':
    main()
