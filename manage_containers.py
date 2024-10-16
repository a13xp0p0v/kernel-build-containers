#!/usr/bin/python3

"""
This tool manages containers for building the Linux kernel with various compilers
"""

import os
import subprocess
import sys
import argparse
import re

supported_compilers = ['gcc-4.9', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9',
                       'gcc-10', 'gcc-11', 'gcc-12', 'gcc-13', 'gcc-14',
                       'clang-5', 'clang-6', 'clang-7', 'clang-8',
                       'clang-9', 'clang-10', 'clang-11', 'clang-12',
                       'clang-13', 'clang-14', 'clang-15', 'clang-16', 'clang-17',
                       'all']

class Container:
    """
    Represents a Docker container configured for building the Linux kernel with a specified compiler


    Class Attributes:
        docker_wrapper (str): wrap commands with sudo (if needed)
        quiet (bool): enable quiet option in Docker build

    Instance Attributes:
        gcc (str): Version of GCC compiler
        clang (str): Version of Clang compiler
        ubuntu (str): Version of Ubuntu
        id (str): Docker image ID
    """

    docker_wrapper = None
    quiet = False

    def __init__(self, gcc_version, clang_version, ubuntu_version):
        if not Container.docker_wrapper:
            Container.docker_wrapper = self.wrap_docker_command()
        self.gcc = gcc_version
        self.clang = clang_version
        self.ubuntu = ubuntu_version
        self.id = self.check()

    def add(self):
        """Build the Docker container with the specified compilers"""
        build_args = ['build',
                      '--build-arg', f'GCC_VERSION={self.gcc}',
                      '--build-arg', f'CLANG_VERSION={self.clang}',
                      '--build-arg', f'UBUNTU_VERSION={self.ubuntu}',
                      '--build-arg', f'UNAME={os.getlogin()}',
                      '--build-arg', f'UID={os.getuid()}',
                      '--build-arg', f'GID={os.getgid()}',
                      '-t', f'kernel-build-container:gcc-{self.gcc}',
                      '-t', f'kernel-build-container:clang-{self.clang}'
        ]
        build_dir = ['.']
        if self.quiet:
            build_args += ['-q']
        cmd = self.docker_wrapper + build_args + build_dir
        subprocess.run(cmd, text=True, check=True)
        self.check()

    def rm(self):
        """Remove the Docker container if it exists and not running"""
        cmd = self.docker_wrapper + ['ps']
        out = subprocess.run(cmd, text=True, check=True, stdout=subprocess.PIPE).stdout
        find = rf'(kernel-build-container:gcc-{self.gcc}|kernel-build-container:clang-{self.clang})'
        running = re.findall(find, out)
        if not running:
            cmd = self.docker_wrapper + ['rmi', '-f', self.id]
            subprocess.run(cmd, text=True, check=True)
            self.check()
            return ''
        return '\n'.join(running)

    def check(self):
        """Check if the Docker container built and parses the image ID"""
        cmd = self.docker_wrapper + ['images', f'kernel-build-container:clang-{self.clang}', '--format', '{{.ID}}']
        out = subprocess.run(cmd, stdout=subprocess.PIPE, text=True, check=True)
        self.id = out.stdout.strip()
        return self.id

    def wrap_docker_command(self):
        """Check if the user is in the Docker group, wrap docker in 'sudo' if not"""
        cmd = ['groups']
        out = subprocess.run(cmd, capture_output = True, text = True, check = True)
        if 'docker' in out.stdout:
            return ['docker']
        print('We need to use sudo to run the Docker')
        return ['sudo', 'docker']

def add_containers(needed_compiler, containers):
    """Add the specified container(s) based on the provided compiler or add all of them"""
    for c in containers:
        if needed_compiler == 'all':
            print(f'Adding Ubuntu-{c.ubuntu} container with GCC-{c.gcc} and Clang-{c.clang}')
            if not c.id:
                c.add()
            else:
                print('[!] WARNING: exists, skipping!')
        if needed_compiler in ('gcc-' + c.gcc, 'clang-' + c.clang):
            if c.id:
                sys.exit(f'[!] ERROR: container with {needed_compiler} already exists!')
            print(f'Adding Ubuntu-{c.ubuntu} container with GCC-{c.gcc} and Clang-{c.clang}')
            c.add()
            return

def remove_containers(containers):
    """Remove Docker container images"""
    out = ''
    for c in containers:
        if c.id:
            print(f'Removing Ubuntu-{c.ubuntu} container with GCC-{c.gcc} and Clang-{c.clang}')
            out = out + c.rm()
    if out:
        print('\nYou still have running containers, that can\'t be removed:\n'+out)

def list_containers(containers):
    """Print built containers"""
    print(f'\n{"Ubuntu":<6} | {"GCC":<6} | {"Clang":<6} | {"Status":<6}')
    print('-' * 34)
    for c in containers:
        status = '[+]' if c.id else '[-]'
        print(f'{c.ubuntu:<6} | {c.gcc:<6} | {c.clang:<6} | {status:<6}')

def main():
    """The main function to manage the containers"""
    parser = argparse.ArgumentParser(description='Manage the kernel-build-containers')
    parser.add_argument('-l','--list', action = 'store_true',
                        help = 'show the kernel build containers')
    parser.add_argument('-a', '--add', choices = supported_compilers, metavar = 'compiler',
                        help=f'build a container with: ({", ".join(supported_compilers)},'
                              'where \'all\' for all of the compilers)')
    parser.add_argument('-r', '--remove', action='store_true',
                        help = 'remove all created containers')
    parser.add_argument('-q','--quiet', action = 'store_true',
                        help = 'suppress container build output')
    args = parser.parse_args()

    if not any([args.list, args.add, args.remove]):
        parser.print_help()
        sys.exit(1)
    if bool(args.list) + bool(args.add) + bool(args.remove) > 1:
        sys.exit('Combining these options doesn\'t make sense!')

    containers = []
    containers += [Container('4.9', '5', '16.04')]
    containers += [Container('5', '6', '16.04')]
    containers += [Container('6', '7', '18.04')]
    containers += [Container('7', '8', '18.04')]
    containers += [Container('8', '9', '20.04')]
    containers += [Container('9', '10', '20.04')]
    containers += [Container('10', '11', '20.04')]
    containers += [Container('11', '12', '22.04')]
    containers += [Container('12', '13', '22.04')]
    containers += [Container('12', '14', '22.04')]
    containers += [Container('13', '15', '23.04')]
    containers += [Container('14', '16', '24.04')]
    containers += [Container('14', '17', '24.04')]

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
