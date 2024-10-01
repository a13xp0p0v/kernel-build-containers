#!/usr/bin/python3

"""
This tool manages containers for building the Linux kernel with various compilers
"""

import os
import subprocess
import sys
import argparse

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
        sudo (str): represents sudo command
        quiet (bool): enable quiet option in Docker build

    Instance Attributes:
        gcc (str): Version of GCC compiler
        clang (str): Version of Clang compiler
        ubuntu (str): Version of Ubuntu
        id (str): Docker image ID
    """

    sudo = ''
    quiet = False

    def __init__(self, gcc_version, clang_version, ubuntu_version):
        self.gcc = gcc_version
        self.clang = clang_version
        self.ubuntu = ubuntu_version
        self.id = self.check()

    def add(self):
        """Build the Docker container with the specified compilers"""
        build_args = ['--build-arg', f'GCC_VERSION={self.gcc}',
                      '--build-arg', f'CLANG_VERSION={self.clang}',
                      '--build-arg', f'UBUNTU_VERSION={self.ubuntu}',
                      '--build-arg', f'UNAME={os.getlogin()}',
                      '--build-arg', f'UID={os.getuid()}',
                      '--build-arg', f'GID={os.getgid()}',
                      '-t', f'kernel-build-container:gcc-{self.gcc}',
                      '-t', f'kernel-build-container:clang-{self.clang}'
        ]

        if self.quiet:
            build_args += ['-q']
        subprocess.run([self.sudo, 'docker', 'build', *build_args, '.'],
                        text=True, check=True)
        self.check()

    def rm(self):
        """Remove the Docker container if it exists and not running"""
        running = subprocess.run(f"{Container.sudo} docker ps | "
                                 f"grep -E 'kernel-build-container:"
                                 f"(gcc-{self.gcc}|clang-{self.clang})' || true",
                                 shell=True, text=True, check=True, stdout=subprocess.PIPE).stdout
        if not running:
            subprocess.run([self.sudo, 'docker', 'rmi', '-f', self.id],
                            text=True, check=True)
            self.check()
            return ''
        return running

    def check(self):
        """Check if the Docker container built and parses the image ID"""
        cmd = subprocess.run([self.sudo, 'docker', 'images',
                              f'kernel-build-container:clang-{self.clang}', '--format', '{{.ID}}'],
                              stdout=subprocess.PIPE,
                              text=True, check=True)
        self.id = cmd.stdout.strip()
        return self.id

def check_group():
    """Check if the user is in the Docker group, return 'sudo' if not"""
    result = subprocess.run(['groups'], capture_output = True,
                            text = True, check = True)
    if 'docker' in result.stdout:
        return ''
    print('We need to use sudo to run the docker')
    return 'sudo'

def add_handler(needed_compiler, containers):
    """Add the specified container(s) based on the provided compiler or add all of them"""
    if needed_compiler == 'all':
        for c in containers:
            print(f'Adding ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang-{c.clang}')
            if not c.id:
                c.add()
            else:
                print('[!] WARNING: exists, skipping!')
        return
    for c in containers:
        if 'gcc-' + c.gcc == needed_compiler:
            if c.id:
                sys.exit(f'[!] ERROR: container with {needed_compiler} already exists!')
            print(f'Adding ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang-{c.clang}')
            c.add()
            return
        if c.clang and 'clang-' + c.clang == needed_compiler:
            if c.id:
                sys.exit(f'[!] ERROR: container with {needed_compiler} already exists!')
            print(f'Adding ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang-{c.clang}')
            c.add()
            return

def remove_handler(containers) -> None:
    """Remove Docker container images"""
    out = ''
    for c in containers:
        if c.id:
            print(f'Removing ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang-{c.clang}')
            out = out + c.rm()
    if out:
        print('\nYou still have running containers, that can\'t be removed:\n', out)

def list_containers(containers):
    """Print built containers"""
    for c in containers:
        if c.id:
            print(f'Ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang-{c.clang}: [+]')
        else:
            print(f'Ubuntu-{c.ubuntu} container with gcc-{c.gcc} and clang {c.clang}: [-]')
    sys.exit(0)

def main():
    """The main function to manage the containers"""
    parser = argparse.ArgumentParser(description='Manage the kernel-build-containers')
    parser.add_argument('-l','--list', action = 'store_true',
                        help = 'show the kernel build containers')
    parser.add_argument('-a', '--add', choices = supported_compilers, metavar = 'compiler',
                        help=f'build a container with: ({", ".join(supported_compilers)},'
                              'where "all" for all of the compilers)')
    parser.add_argument('-r', '--remove', choices = ['all'], metavar = 'all',
                        help = 'remove all created containers')
    parser.add_argument('-q','--quiet', action = 'store_true',
                        help = 'suppress container build output')
    args = parser.parse_args()

    if not any([args.list, args.add, args.remove, args.quiet]):
        parser.print_help()
        sys.exit(1)
    if bool(args.list) + bool(args.add) + bool(args.remove) > 1:
        sys.exit("Combining these options doesn't make sense!")

    Container.sudo = check_group()
    if args.quiet:
        Container.quiet = True

    containers = []
    containers += [Container("4.9", "5", "16.04")]
    containers += [Container("5", "6", "16.04")]
    containers += [Container("6", "7", "18.04")]
    containers += [Container("7", "8", "18.04")]
    containers += [Container("8", "9", "20.04")]
    containers += [Container("9", "10", "20.04")]
    containers += [Container("10", "11", "20.04")]
    containers += [Container("11", "12", "22.04")]
    containers += [Container("12", "13", "22.04")]
    containers += [Container("12", "14", "22.04")]
    containers += [Container("13", "15", "23.04")]
    containers += [Container("14", "16", "24.04")]
    containers += [Container("14", "17", "24.04")]

    if args.list:
        list_containers(containers)

    if args.add:
        add_handler(args.add, containers)
        list_containers(containers)

    if args.remove:
        remove_handler(containers)
        list_containers(containers)

if __name__ == '__main__':
    main()
