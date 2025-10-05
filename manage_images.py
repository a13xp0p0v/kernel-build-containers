#!/usr/bin/python3

"""
This tool manages container images for building the Linux kernel with Clang and GCC compilers
"""

import os
import subprocess
import sys
import argparse
import pwd
import grp

supported_compilers = ['clang-5', 'clang-6', 'clang-7', 'clang-8',
                       'clang-9', 'clang-10', 'clang-11', 'clang-12',
                       'clang-13', 'clang-14', 'clang-15', 'clang-16', 'clang-17',
                       'gcc-4.9', 'gcc-5', 'gcc-6', 'gcc-7', 'gcc-8', 'gcc-9',
                       'gcc-10', 'gcc-11', 'gcc-12', 'gcc-13', 'gcc-14',
                       'all']

class ContainerImage:
    """
    Represents a container image for building the Linux kernel with a specified compiler

    Class Attributes:
        runtime (str): docker/podman flag
        runtime_cmd (List): commands for calling the container runtime
        quiet (bool): quiet mode for hiding the container image build log

    Instance Attributes:
        clang (str): Clang version
        clang_tag (str): Clang tag of the container image
        gcc (str): GCC version
        gcc_tag (str): GCC tag of the container image
        ubuntu (str): Ubuntu version
        id (str): container image ID
    """

    runtime = ''
    runtime_cmd = None
    quiet = False

    def __init__(self, clang_version, gcc_version, ubuntu_version):
        if not ContainerImage.runtime_cmd:
            ContainerImage.runtime_cmd = self.identify_runtime_cmd()
        self.clang = clang_version
        self.clang_tag = 'kernel-build-container:clang-' + self.clang
        self.gcc = gcc_version
        self.gcc_tag = 'kernel-build-container:gcc-' + self.gcc
        self.ubuntu = ubuntu_version
        self.id = self.find_id()

    def build(self):
        """Build a container image that provides the specified compilers"""
        if self.id:
            print(f'\nThe container image providing Clang {self.clang} and GCC {self.gcc} exists: {self.id}')
            return

        print(f'\nBuild a container image providing Clang {self.clang} and GCC {self.gcc}')
        build_args = ['build',
                      '--build-arg', f'CLANG_VERSION={self.clang}',
                      '--build-arg', f'GCC_VERSION={self.gcc}',
                      '--build-arg', f'UBUNTU_VERSION={self.ubuntu}',
                      '--build-arg', f'UNAME={pwd.getpwuid(os.getuid()).pw_name}',
                      '--build-arg', f'GNAME={grp.getgrgid(os.getgid()).gr_name}',
                      '--build-arg', f'UID={os.getuid()}',
                      '--build-arg', f'GID={os.getgid()}',
                      '-t', self.clang_tag,
                      '-t', self.gcc_tag]
        if self.quiet:
            print('[!] INFO: Quiet mode, please wait...')
            build_args += ['-q']
        build_dir = ['.']
        cmd = self.runtime_cmd + build_args + build_dir
        subprocess.run(cmd, text=True, check=True)
        self.id = self.find_id()

    def rm(self):
        """Try to remove the container image if it exists"""
        if not self.id:
            print(f'\nNo container image providing Clang {self.clang} and GCC {self.gcc}')
            return

        print(f'\nRemove the container image {self.id} providing Clang {self.clang} and GCC {self.gcc}')

        # We need to get full ID of the container image,
        # since Podman fails to search containers using a short one (strange!)
        get_full_id_cmd = self.runtime_cmd + ['inspect', f'{self.id}', '--format', '{{.ID}}']
        out = subprocess.run(get_full_id_cmd, text=True, check=True, stdout=subprocess.PIPE)
        full_id = out.stdout.strip()
        assert(full_id), f'[-] ERROR: Looks like the image {self.id} is already removed'
        get_containers_cmd = self.runtime_cmd + ['ps', '-a', '--filter', f'ancestor={full_id}',
                                                 '--format', '{{.ID}}']
        out = subprocess.run(get_containers_cmd, text=True, check=True, stdout=subprocess.PIPE)
        running_containers = out.stdout.strip()
        if running_containers:
            print(f'[!] WARNING: Removing the image {self.id} failed, some containers use it')
        else:
            rmi_cmd = self.runtime_cmd + ['rmi', '-f', self.id]
            subprocess.run(rmi_cmd, text=True, check=True)

        # Update ContainerImage.id to reflect the changes
        self.id = self.find_id()

    def find_id(self):
        """Find the ID of the container image. Return an empty string if it doesn't exist."""
        find_clang_cmd = self.runtime_cmd + ['images', self.clang_tag, '--format', '{{.ID}}']
        out = subprocess.run(find_clang_cmd, text=True, check=True, stdout=subprocess.PIPE)
        clang_id = out.stdout.strip()
        if clang_id:
            find_gcc_cmd = self.runtime_cmd + ['images', self.gcc_tag, '--format', '{{.ID}}']
            out = subprocess.run(find_gcc_cmd, text=True, check=True, stdout=subprocess.PIPE)
            gcc_id = out.stdout.strip()
            # gcc_id may differ if it's overridden by another container image, but it should exist
            if not gcc_id:
                sys.exit(f'[-] ERROR: Invalid image "{self.clang_tag}" ' \
                          'without the corresponding GCC tag, please remove it manually')
            return clang_id.split()[0] # a fix for the Podman issue (duplicated results),
                                       # see https://github.com/containers/podman/issues/25725
        else:
            return clang_id

    def identify_runtime_cmd(self):
        """Identify the commands for working with the container runtime"""
        try:
            cmd = [self.runtime, 'ps']
            out = subprocess.run(cmd, text=True, check=False, capture_output=True)
            if out.returncode == 0:
                return [self.runtime]
            if self.runtime == 'docker' and 'permission denied' in out.stderr:
                print('[!] INFO: We need "sudo" for working with Docker containers')
                return ['sudo', self.runtime]
            sys.exit(f'[-] ERROR: Testing "{" ".join(cmd)}" gives unknown error:\n{out.stderr}')
        except FileNotFoundError:
            sys.exit('[-] ERROR: The container runtime is not installed')

def build_images(needed_compiler, images):
    """Build the container images providing the specified compilers"""
    for c in images:
        if needed_compiler in ('all', 'clang-' + c.clang, 'gcc-' + c.gcc):
            # Special case for GCC: build the *first* known container image providing this compiler
            c.build()
            if needed_compiler != 'all':
                # We need only one container image providing this compiler
                return

def remove_images(needed_compiler, images):
    """Remove the container images providing the specified compilers"""
    fail_cnt = 0
    for c in images:
        if needed_compiler in ('all', 'clang-' + c.clang, 'gcc-' + c.gcc):
            # Special case for GCC: remove all container images providing this compiler
            c.rm()
            if c.id:
                fail_cnt += 1
    if fail_cnt:
        print(f'\n[!] WARNING: failed to remove {fail_cnt} container image(s), see the log above')

def list_images(images):
    """Show the images and their IDs"""
    print('\nCurrent status:')
    print('-' * 44)
    print(f' {"Ubuntu":<6} | {"Clang":<6} | {"GCC":<6} | {ContainerImage.runtime.capitalize() + " Image ID"}')
    print('-' * 44)
    for c in images:
        print(f' {c.ubuntu:<6} | {c.clang:<6} | {c.gcc:<6} | {c.id if c.id else "-"}')
    print('-' * 44)

def main():
    """The main function for managing the images for kernel-build-containers"""
    parser = argparse.ArgumentParser(description='Manage the images for kernel-build-containers')
    parser.add_argument('-l', '--list', action='store_true',
                        help='show the container images and their IDs')
    parser.add_argument('-b', '--build', nargs='?', const='all', choices=supported_compilers, metavar='compiler',
                        help=f'build a container image providing: {" / ".join(supported_compilers)} '
                              '("all" is default, the tool will build all images if no compiler is specified)')
    parser.add_argument('-q', '--quiet', action='store_true',
                        help='suppress the container image build output (for using with --build)')
    parser.add_argument('-r', '--remove', nargs='?', const='all', choices=supported_compilers, metavar='compiler',
                        help=f'remove container images providing: {" / ".join(supported_compilers)} '
                              '("all" is default, the tool will remove all images if no compiler is specified)')
    parser.add_argument('-d', '--docker', action='store_true',
                        help='force to use the Docker container engine (default)')
    parser.add_argument('-p', '--podman', action='store_true',
                        help='force to use the Podman container engine instead of default Docker')
    args = parser.parse_args()

    if not any((args.list, args.build, args.remove)):
        parser.print_help()
        sys.exit(1)

    if bool(args.list) + bool(args.build) + bool(args.remove) > 1:
        sys.exit('[-] ERROR: Invalid combination of options')

    if args.quiet:
        if not args.build:
            sys.exit('[-] ERROR: "--quiet" should be used only with the "--build" option')
        ContainerImage.quiet = True

    if args.podman and args.docker:
        sys.exit('[-] ERROR: Multiple container engines specified')
    if args.docker:
        print('[+] Force to use the Docker container engine')
        ContainerImage.runtime = 'docker'
    elif args.podman:
        print('[+] Force to use the Podman container engine')
        print(f'[!] INFO: Working with Podman images belonging to "{pwd.getpwuid(os.getuid()).pw_name}" (UID {os.getuid()})')
        ContainerImage.runtime = 'podman'
    else:
        print(f'[+] Docker container engine is chosen (default)')
        ContainerImage.runtime = 'docker'

    images = []
    images += [ContainerImage('5', '4.9', '16.04')]
    images += [ContainerImage('6', '5', '16.04')]
    images += [ContainerImage('7', '6', '18.04')]
    images += [ContainerImage('8', '7', '18.04')]
    images += [ContainerImage('9', '8', '20.04')]
    images += [ContainerImage('10', '9', '20.04')]
    images += [ContainerImage('11', '10', '20.04')]
    images += [ContainerImage('12', '11', '22.04')]
    images += [ContainerImage('13', '12', '22.04')]
    images += [ContainerImage('14', '12', '22.04')]
    images += [ContainerImage('15', '13', '24.04')]
    images += [ContainerImage('16', '14', '24.04')]
    images += [ContainerImage('17', '14', '24.04')]

    if args.list:
        list_images(images)
        sys.exit(0)

    if args.build:
        build_images(args.build, images)
        list_images(images)
        sys.exit(0)

    if args.remove:
        remove_images(args.remove, images)
        list_images(images)
        sys.exit(0)

if __name__ == '__main__':
    main()
