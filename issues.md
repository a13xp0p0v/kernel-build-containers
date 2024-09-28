Export of Github issues for [a13xp0p0v/kernel-build-containers](https://github.com/a13xp0p0v/kernel-build-containers).

# [\#24 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/24) `merged`: add xz-utils package
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=c8a707b5460502b823b0b697147e94d616c7617d&v=4" width="50">[flipthewho](https://github.com/flipthewho) opened issue at [2024-09-20 06:53](https://github.com/a13xp0p0v/kernel-build-containers/pull/24):

hello, @a13xp0p0v !
i have litlle PR
first i got this error
```
      CALL    /home/vyashnikov/src/scripts/checksyscalls.sh      CHK     include/generated/compile.h
      UPD     include/generated/compile.h      CC      init/version.o
      AR      init/built-in.a      CHK     kernel/kheaders_data.tar.xz
      GEN     kernel/kheaders_data.tar.xz    /bin/sh: 1: xz: not found
    tar: kernel/kheaders_data.tar.xz: Cannot write: Broken pipe    tar: Child returned status 127
    tar: Error is not recoverable: exiting now    make[2]: *** [/home/vyashnikov/src/kernel/Makefile:150: kernel/kheaders_data.tar.xz] Error 2
    ...
 ```
 i also checked this util in dockerfile and container and didnt found `xz`
 

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-22 14:42](https://github.com/a13xp0p0v/kernel-build-containers/pull/24#issuecomment-2366821067):

Cool, thank you @flipthewho.
Merged.


-------------------------------------------------------------------------------

# [\#23 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/23) `merged`: Add dwarves package

#### <img src="https://avatars.githubusercontent.com/u/67371653?v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-17 12:15](https://github.com/a13xp0p0v/kernel-build-containers/pull/23):

Hello, I've decided to add dwarves package to the apt-get package list in Dockerfile. I think this package must be added alongside with cpio, which is mentioned here #20, because it is required to build many kernels with debian kconfig (which is a really popular one I suppose).

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-18 20:16](https://github.com/a13xp0p0v/kernel-build-containers/pull/23#issuecomment-2359326928):

Thank you!
Merged.


-------------------------------------------------------------------------------

# [\#22 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/22) `open`: Add manage_containers.py

#### <img src="https://avatars.githubusercontent.com/u/67371653?v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-13 17:07](https://github.com/a13xp0p0v/kernel-build-containers/pull/22):

Hello, I've decided to make a python script for these issues #12 #13 

So, here is python script, documentation, tests, some fixes for old clang in dockerfile and make_linux.py!




-------------------------------------------------------------------------------

# [\#21 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/21) `merged`: Update Dockerfile for optimisation and old clang
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/67371653?v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-13 16:57](https://github.com/a13xp0p0v/kernel-build-containers/pull/21):

Hello, I've decided that Dockerfile can be optimized by removing duplicate gcc and g++ versions. Since they are just meta packages containing the one specified version of distinct package. You can check it by searching gcc in this repo http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-amd64/

The economy of space will be really nice:
|                                   | old    | new    |
| --------------------------------- | ------ | ------ |
| kernel-build-container   clang-17 | 6.02GB | 4.89GB |
| kernel-build-container   clang-15 | 3.83GB | 3.49GB |
| kernel-build-container   clang-14 | 2.21GB | 1.88GB |
| kernel-build-container   clang-10 | 1.38GB | 1.38GB |
| kernel-build-container   clang-8  | 1.75GB | 1.4GB  |
| kernel-build-container   clang-7  | 2.04GB | 1.49GB |

Also, I've added support for old clangs, so that they can be added in future! To be honest, I will try to add them really soon!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-18 22:33](https://github.com/a13xp0p0v/kernel-build-containers/pull/21#issuecomment-2359562645):

Excellent finding, thanks @Willenst.
I've added a fix https://github.com/a13xp0p0v/kernel-build-containers/commit/be11369dc6b7b59bc565186f2e9c3e3fede3253f and merged this branch.


-------------------------------------------------------------------------------

# [\#20 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/20) `merged`: Add cpio binary and help with silent and parallel builds

#### <img src="https://avatars.githubusercontent.com/u/1080524?v=4" width="50">[srikard](https://github.com/srikard) opened issue at [2024-09-04 11:10](https://github.com/a13xp0p0v/kernel-build-containers/pull/20):

Sometimes kernel build fails due to non availability of cpio archive in the container.
the kernel/gen_kheaders.sh file needs cpio archive to build kernel/kheaders_data.tar.xz

Similarly silent and parallel builds will help to build faster and show only relevant warnings or error messages.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-04 15:02](https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2329307798):

Hello @srikard,

Thanks a lot for your pull request! I like the idea.

I agree that parallel build should become default.
But we should provide a parameter for `make_linux.py` for disabling it and having a single-thread build (there are cases when it's useful).
Could you please implement a `-t` (single Tread build) parameter for `make_linux.py`?

And I think that verbose kernel build should stay default.
Could you please add a `-q` (quiet) parameter for `make_linux.py` for silent build?

Would you like to work on it?

#### <img src="https://avatars.githubusercontent.com/u/1080524?v=4" width="50">[srikard](https://github.com/srikard) commented at [2024-09-04 16:51](https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2329554385):

* Alexander Popov ***@***.***> [2024-09-04 08:02:35]:

> Hello @srikard,
> 
> Thanks a lot for your pull request! I like the idea.
> 
> I agree that parallel build should become default.
> But we should provide a parameter for `make_linux.py` for disabling it and having a single-thread build (there are cases when it's useful).
> Could you please implement a `-t` (single Tread build) parameter for `make_linux.py`?
> 
> And I think that verbose kernel build should stay default.
> Could you please add a `-q` (quiet) parameter for `make_linux.py` for silent build?
> 
> Would you like to work on it?
> 

Okay, will do, However may not be immediately though.
Also I think its better to keep the options compatible with kernel makefile
where possible. 

something like -s for silent
and -j for parallel build.

> -- 
> Reply to this email directly or view it on GitHub:
> https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2329307798
> You are receiving this because you were mentioned.
> 
> Message ID: ***@***.***>

-- 
Thanks and Regards
Srikar Dronamraju

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-07 19:14](https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2336410540):

The `-s` parameter is already used for source path. So I would recommend `-q` like quiet.

The `-j` parameter doesn't fit: we need parallel build as default behavior for `make_linux.py` (without parameters).
So we need a `make_linux.py` parameter for a single-tread build, corresponding to `make -j1`. How about `-t` (single Tread build). Any other ideas?

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-19 00:42](https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2359683129):

Hello @srikard,

I've finished the implementation and merged this branch: https://github.com/a13xp0p0v/kernel-build-containers/commit/c9a015cdcd8c826502d4d580bcbafa5ba6153cfb.

Finally, the feature looks like this:
```
+    parser.add_argument('-q', action='store_true',
+                        help='for running `make` in quiet mode')
+    parser.add_argument('-t', action='store_true',
+                        help='for running `make` in single-threaded mode (multi-threaded by default)')
     parser.add_argument('make_args', metavar='...', nargs=argparse.REMAINDER,
                         help='additional arguments for \'make\', can be separated by -- delimiter')
     args = parser.parse_args()
@@ -197,6 +201,19 @@ def main():
                 sys.exit('[-] Don\'t specify "CROSS_COMPILE=", we will take care of that')
             if arg.startswith('CC='):
                 sys.exit('[-] Don\'t specify "CC=", we will take care of that')
+            if arg.startswith('-j'):
+                sys.exit('[-] Don\'t specify "-j", by default we run \'make\' in parallel on all CPUs')
+
+    if args.q:
+        print('[+] Going to run \'make\' in quiet mode')
+        make_args.insert(0, '-s')
+
+    if not args.t:
+        cpu_count = os.sysconf('SC_NPROCESSORS_ONLN')
+        print(f'[+] Going to run \'make\' on {cpu_count} CPUs')
+        make_args = ['-j', str(cpu_count)] + make_args
+    else:
+        print(f'[+] Going to run \'make\' in single-threaded mode')
 
     build_kernels(args.a, args.k, args.s, args.o, compilers, make_args)
```

Does it work for you?

#### <img src="https://avatars.githubusercontent.com/u/1080524?v=4" width="50">[srikard](https://github.com/srikard) commented at [2024-09-19 10:21](https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2360595882):

* Alexander Popov ***@***.***> [2024-09-18 17:42:36]:

> Hello @srikard,
> 
> I've finished the implementation and merged this branch.
> 
> 
> Does it work for you?
> 

Tested it out, and it works well. 
Thanks for adding this 

> -- 
> Reply to this email directly or view it on GitHub:
> https://github.com/a13xp0p0v/kernel-build-containers/pull/20#issuecomment-2359683129
> You are receiving this because you were mentioned.
> 
> Message ID: ***@***.***>

-- 
Thanks and Regards
Srikar Dronamraju


-------------------------------------------------------------------------------

# [\#19 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/19) `closed`: Support for POWER arch builds

#### <img src="https://avatars.githubusercontent.com/u/14011921?u=38f0b728c74435aeefe7c17198206fc43384ce35&v=4" width="50">[mchauras-linux](https://github.com/mchauras-linux) opened issue at [2024-09-04 09:27](https://github.com/a13xp0p0v/kernel-build-containers/pull/19):

This patch supports build for ppc64le arch

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-04 15:07](https://github.com/a13xp0p0v/kernel-build-containers/pull/19#issuecomment-2329322183):

Hello @mchauras-linux,

May I ask why did you close this pull request?

Thanks!

#### <img src="https://avatars.githubusercontent.com/u/14011921?u=38f0b728c74435aeefe7c17198206fc43384ce35&v=4" width="50">[mchauras-linux](https://github.com/mchauras-linux) commented at [2024-09-13 06:10](https://github.com/a13xp0p0v/kernel-build-containers/pull/19#issuecomment-2348110176):

This still doesn't support ppc arch, it only has support for ppc64le.
If you feel this is enough I can reopen this. But it still lacks support for ppc64 and ppc


-------------------------------------------------------------------------------

# [\#18 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/18) `open`: Give user a choice to choose which container to build

#### <img src="https://avatars.githubusercontent.com/u/14011921?u=38f0b728c74435aeefe7c17198206fc43384ce35&v=4" width="50">[mchauras-linux](https://github.com/mchauras-linux) opened issue at [2024-09-04 09:22](https://github.com/a13xp0p0v/kernel-build-containers/pull/18):

Created a fucntion for every container build, user passes the argument and builds only the version user asked for.
This saves a lot of time and space on the disk

If no arguments are provided all the containers will be built. I kept it that way since I didn't wanna change the legacy behaviour.




-------------------------------------------------------------------------------

# [\#17 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/17) `open`: feature request: support for devcontainers
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/6632321?u=f953374bf2b50a16b38f3a2b50d4ffff0f3acc18&v=4" width="50">[lattice0](https://github.com/lattice0) opened issue at [2024-04-28 20:27](https://github.com/a13xp0p0v/kernel-build-containers/issues/17):

With code errors highliting and all possible include paths inserted.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-07-06 10:24](https://github.com/a13xp0p0v/kernel-build-containers/issues/17#issuecomment-2211731019):

Hello @lattice0,

I don't have experience with devcontainers.
Could you give a use-case example?

As I can understand, this feature requires creating a `devcontainer.json` file describing the `kernel-build-containers` functionality. Am I right?

Thanks!


-------------------------------------------------------------------------------

# [\#16 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/16) `closed`: Don't overwrite `.config` in the output directory with the kconfig file specified with the `-k` argument of `make_linux.py`
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2024-03-25 13:00](https://github.com/a13xp0p0v/kernel-build-containers/issues/16):






-------------------------------------------------------------------------------

# [\#15 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/15) `merged`: start_container: support setting environment variables

#### <img src="https://avatars.githubusercontent.com/u/89150207?v=4" width="50">[vobst](https://github.com/vobst) opened issue at [2024-01-26 10:52](https://github.com/a13xp0p0v/kernel-build-containers/pull/15):

Change the parsing of optional flag parameters after the three mandatory positional arguments to use a while loop. Makes it easier to add more arguments in the future. 

Everything after `--` will be passed to the docker command. Note: This change will break existing scripts that execute commands in the container.

As a first use-case: Add support for specifying environment variables for the container on the command line in a space-separated list. Note: It is not possible to set environment variables that contain spaces.

Why: I like to customize builds through environment variables and doing `sh -c "FOO=BAR make"` is ugly. :)

Examples:
```console
$ export VAR=something
$ ./start_container.sh gcc-7 $(pwd) /tmp -e "FOO=BAR FOOBAR= VAR=$VAR" -- /usr/bin/env
Hey, we gonna use sudo for running docker
Starting "kernel-build-container:gcc-7"
Source code directory "/mnt/example/kernel-build-containers" is mounted at "~/src"
Build output directory "/tmp" is mounted at "~/out"
Container environment:  -e FOO=BAR -e FOOBAR= -e VAR=something
Run docker in interactive mode
Gonna run "/usr/bin/env"

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=e769fbdf9d72
FOO=BAR
FOOBAR=
VAR=something
```

Note: `./start_container.sh gcc-7 $(pwd) /tmp -e "FOO=BAR" -e "FOOBAR=" -e "VAR=$VAR" -- /usr/bin/env` also works...

As further use case for the while-loop parsing: Add `--help` and `--verbose` flags.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-03-24 15:31](https://github.com/a13xp0p0v/kernel-build-containers/pull/15#issuecomment-2016845610):

Hello @vobst,

Nice idea, thanks for the pull request!

I've found an infinite loop bug, I'll push the fix to the [add-env-support](https://github.com/vobst/kernel-build-containers/tree/add-env-support) branch on [vobst/kernel-build-containers](https://github.com/vobst/kernel-build-containers).

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-03-25 06:10](https://github.com/a13xp0p0v/kernel-build-containers/pull/15#issuecomment-2017296570):

I also:

- forced using the `-e` argument of `start_container.sh` for each env variable, similar to `-e` in `grep`
- fixed the `start_container.sh` calling in `make_linux.py`
- improved the output of `start_container.sh`

#### <img src="https://avatars.githubusercontent.com/u/89150207?v=4" width="50">[vobst](https://github.com/vobst) commented at [2024-03-25 13:52](https://github.com/a13xp0p0v/kernel-build-containers/pull/15#issuecomment-2018055938):

Hi, thanks for picking this up and fixing those issues! Much appreciated :)


-------------------------------------------------------------------------------

# [\#14 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/14) `merged`: Install bsdmainutils in containers

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2023-10-23 15:20](https://github.com/a13xp0p0v/kernel-build-containers/pull/14):

Building the kernel sometimes requires the hexdump tool, which is a part of the bsdmainutils package.




-------------------------------------------------------------------------------

# [\#13 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/13) `open`: Stop/Remove all running containers before removing images
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2023-10-04 21:11](https://github.com/a13xp0p0v/kernel-build-containers/issues/13):

Thanks to @joseigor for the PoC: https://github.com/a13xp0p0v/kernel-build-containers/pull/11

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-11-17 12:34](https://github.com/a13xp0p0v/kernel-build-containers/issues/13#issuecomment-1816337349):

Looked at the design.

Decided to create a python script `manage_containers.py`, that will substitute `build_containers.sh` and `rm_containers.sh`.

It will support choosing specific containers for removing.


-------------------------------------------------------------------------------

# [\#12 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/12) `open`: Allow the user to choose a specific version of the container image to build
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2023-10-04 21:10](https://github.com/a13xp0p0v/kernel-build-containers/issues/12):

Thanks to @joseigor for the PoC: #11

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-11-17 12:33](https://github.com/a13xp0p0v/kernel-build-containers/issues/12#issuecomment-1816335617):

Looked at the design.

Decided to create a python script `manage_containers.py`, that will substitute `build_containers.sh` and `rm_containers.sh`.

It will support choosing specific containers.


-------------------------------------------------------------------------------

# [\#11 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/11) `closed`: Allow the user to choose a specific version of the container image to build / Stop/Remove all running containers before removing images

#### <img src="https://avatars.githubusercontent.com/u/11823457?u=d10caa6e981ec5a3fa75a0f3ae02af537f983c18&v=4" width="50">[joseigor](https://github.com/joseigor) opened issue at [2023-06-13 18:53](https://github.com/a13xp0p0v/kernel-build-containers/pull/11):

This PR includes:
-  Allow the user to choose specific versions to build as well as all versions. (Building all docker's images for all supported versions GCC/Clang is time/space consuming and is likely this is not needed in all cases.)
- Refactor of `rm_constainers.sh` to stop and remove all running containers before removing the associated docker image.
- Move common variables to the  `config. sh` file.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-10-04 20:44](https://github.com/a13xp0p0v/kernel-build-containers/pull/11#issuecomment-1747612598):

Hello @joseigor,

Excuse me for such a delay -- I missed the notification :(

I like the idea of your PR!

I'm not excellent in bash, so I'll try to reimplement your logic in python. 

I'll kindly ask you to have a look when it's ready.


-------------------------------------------------------------------------------

# [\#10 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/10) `closed`: Support for Clang 15

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2023-02-17 10:23](https://github.com/a13xp0p0v/kernel-build-containers/issues/10):

It would be nice to add support for Clangs 15+ to enable building KMSAN and for [better KASAN support](https://reviews.llvm.org/D122724).

LLVM provides an [apt repository](https://apt.llvm.org/) for Clang. An example reference of a Dockerfile can be found in [syzkaller repo](https://github.com/google/syzkaller/pull/3651/files).

Thank you!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-04-02 12:23](https://github.com/a13xp0p0v/kernel-build-containers/issues/10#issuecomment-1493318072):

Hello @xairy,

Got some time to work on this.

It turned out that Ubuntu 22.04 supports clang-15. I've added a new container with it.

Is it fine? Do you need a separate container with a bleeding-edge fresh clang from the LLVM apt repository?

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2023-04-03 16:35](https://github.com/a13xp0p0v/kernel-build-containers/issues/10#issuecomment-1494640208):

Yes, Clang 15 is what I needed. Thank you a lot!


-------------------------------------------------------------------------------

# [\#9 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/9) `closed`: Investigate support for menuconfig
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2022-09-08 20:56](https://github.com/a13xp0p0v/kernel-build-containers/issues/9):

It would be nice if `menuconfig` worked via the `./make_linux.py` script.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-12-28 17:25](https://github.com/a13xp0p0v/kernel-build-containers/issues/9#issuecomment-1871362918):

Hey @xairy,

Now we can configure the Linux kernel with `menuconfig` in the needed container.

The `make_linux.py` tool supports the interactive mode for `make menuconfig`.

Please have a try!

https://github.com/a13xp0p0v/kernel-build-containers?tab=readme-ov-file#building-linux-kernel

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2024-01-08 02:39](https://github.com/a13xp0p0v/kernel-build-containers/issues/9#issuecomment-1880312675):

Tested, works! Thanks a lot!


-------------------------------------------------------------------------------

# [\#8 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/8) `merged`: Install sparse

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2022-09-08 18:23](https://github.com/a13xp0p0v/kernel-build-containers/pull/8):

Allows to run the sparse static checks inside the container.




-------------------------------------------------------------------------------

# [\#7 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/7) `closed`: Switch Clang container to Ubuntu 22.04

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2022-09-08 18:19](https://github.com/a13xp0p0v/kernel-build-containers/pull/7):

The current Ubuntu 21.04 container fails to install `clang` for whatever reason.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2022-09-18 14:49](https://github.com/a13xp0p0v/kernel-build-containers/pull/7#issuecomment-1250324597):

Thanks, @xairy 

Ubuntu 21.04 is EoL.
I also moved the `kernel-build-container:gcc-11` to Ubuntu 22.04.


-------------------------------------------------------------------------------

# [\#6 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/6) `closed`: Support building Rocky Linux RPM packages with custom patches
**Labels**: `enhancement`


#### <img src="(unknown)" width="50">[(unknown)]((unknown)) opened issue at [2022-05-17 01:31](https://github.com/a13xp0p0v/kernel-build-containers/issues/6):

I'm opening this to remind myself that I should clean up the modifications I have made to use rpmbuilder for building el8 RPM packages.

The only catch is I'm going the patching manually, in the spec file.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2022-05-31 00:04](https://github.com/a13xp0p0v/kernel-build-containers/issues/6#issuecomment-1141548137):

Hi @vogelfreiheit,

I'm looking forward to testing your pull request.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-12-28 17:30](https://github.com/a13xp0p0v/kernel-build-containers/issues/6#issuecomment-1871365663):

Closing the issue since the @vogelfreiheit account has been deleted.


-------------------------------------------------------------------------------

# [\#5 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/5) `closed`: Unprivileged container support
**Labels**: `enhancement`


#### <img src="(unknown)" width="50">[(unknown)]((unknown)) opened issue at [2022-05-17 01:30](https://github.com/a13xp0p0v/kernel-build-containers/issues/5):

Hi,

I have adapted the code to use a -cap_all and non privileged user + immutable filesystem to build the kernels.
However, I have not adapted make_linux.py to support it yet. I'm adding this as a reminder, if I have some time to prepare the code and send it over, or if you wish to implement it your own way.



#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2022-05-31 00:04](https://github.com/a13xp0p0v/kernel-build-containers/issues/5#issuecomment-1141548076):

Hi @vogelfreiheit,

I'm looking forward to testing your pull request.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-12-28 17:29](https://github.com/a13xp0p0v/kernel-build-containers/issues/5#issuecomment-1871365177):

Closing the issue since the @vogelfreiheit account has been deleted.


-------------------------------------------------------------------------------

# [\#4 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/4) `closed`: Support building with Clang
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2020-11-02 22:16](https://github.com/a13xp0p0v/kernel-build-containers/issues/4):

I see that README already mentions this, but I have some additional points on this, so I'll just put them here.

Kernel build allows to specify the compiler and the assembler separately. Ideally there's support for at least this three modes: compiler=GCC, assembler=GCC (the one that is implemented right now); compiler=Clang, assembler=GCC (the one I currently use with some hacks on top of the existing code); compiler=Clang, assembler=Clang (the one that eventually might also be useful; requires  `LLVM_IAS=1` provided to `make`).

There are also multiple different versions of GCC and Clang, which might need to be used in different combinations. E.g. initially I used Clang 10 + GCC 10, but recently switched to Clang 11 + GCC 10, as the kernel doesn't support Clang 10 anymore. Maybe this means that we need a single container with multiple different compilers installed and a way to choose between them.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-11-03 10:47](https://github.com/a13xp0p0v/kernel-build-containers/issues/4#issuecomment-721040812):

Cool! 
Yes, adding Clang support in `kernel-build-containers` is very useful.

What is your workflow in details?
Do you use Clang provided by the distro (Ubuntu in our case)?

I haven't tried to build the kernel with Clang yet.
So I would really appreciate your links to the tutorials / documentation about combining Clang and GCC for building the Linux kernel.

Thanks a lot!

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2020-11-05 17:45](https://github.com/a13xp0p0v/kernel-build-containers/issues/4#issuecomment-722533269):

> Yes, adding Clang support in `kernel-build-containers` is very useful.

Yes, that would be quite cool! But even without Clang, this tool is awesome, thank you for it!

> Do you use Clang provided by the distro (Ubuntu in our case)?

Yes, I modified the `Dockerfile` to use Ubuntu 20.10 and install `clang-11` (or, previously, `clang-10`, which worked with Ubuntu 20.04).

> What is your workflow in details?

Currently I use `kernel-build-containers` to cross-compile arm64 kernel with a bunch of different configs. I use Clang 11 as compiler and GCC 10 as assembler.

The quick hack I did to enable Clang (besides installing it) is:

``` python
--- a/make_linux.py
+++ b/make_linux.py
@@ -19,7 +19,8 @@ def get_cross_compile_args(arch):
     if arch == 'i386':
         return ['ARCH=i386']
     if arch == 'aarch64':
-        return ['ARCH=arm64', 'CROSS_COMPILE=aarch64-linux-gnu-']
+        return ['ARCH=arm64', 'CROSS_COMPILE=aarch64-linux-gnu-', 'CC=clang-11']
```

I've initially wanted to use Clang as assembler as well, but unfortunately arm64 kernel doesn't yet seem to assemble with Clang successfully.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2021-09-04 19:20](https://github.com/a13xp0p0v/kernel-build-containers/issues/4#issuecomment-913026092):

Hi @xairy ! Hello everyone!

I've added the basic **clang** support in `kernel-build-containers`.

Now we have additional `kernel-build-container:clang-12`, which goes with `clang-12` and `gcc-10`.

For the Linux kernel compilation, the `make_linux.py` utility automatically adds the proper `CC` argument depending on the chosen compiler. No need to worry about it. And the `LLVM` argument may be added manually after the `--` delimiter.

The kernel build example:

```console
$ python3 make_linux.py -a aarch64 -k ~/linux/experiment.config -s ~/linux/linux -o ~/linux/build_out -c clang-12 -- -j5
[+] Going to build the Linux kernel for aarch64
[+] Using "/home/a13x/linux/experiment.config" as kernel config
[+] Using "/home/a13x/linux/linux" as Linux kernel sources directory
[+] Using "/home/a13x/linux/build_out" as build output directory
[+] Going to build with: clang-12
[+] Have additional arguments for 'make': -j5

=== Building with clang-12 ===
Output subdirectory for this build: /home/a13x/linux/build_out/experiment__aarch64__clang-12
Output subdirectory already exists, use it (no cleaning!)
Copy kconfig to output subdirectory as ".config"
Going to save build log to "build_log.txt" in output subdirectory
Compiling with clang requires 'CC=clang'
Add arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh clang-12 /home/a13x/linux/linux /home/a13x/linux/build_out/experiment__aarch64__clang-12 -n make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:clang-12"
    Source code directory "/home/a13x/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/linux/build_out/experiment__aarch64__clang-12" is mounted at "~/out"
    Run docker in NON-interactive mode
    Gonna run "make O=~/out/ CC=clang ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1"
    
    make[1]: Entering directory '/home/a13x/out'
      SYNC    include/config/auto.conf.cmd
      GEN     Makefile
...
    make[1]: Leaving directory '/home/a13x/out'
The container returned 0
See build log: /home/a13x/linux/build_out/experiment__aarch64__clang-12/build_log.txt
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/linux/build_out/experiment__aarch64__clang-12"
    OK, "container.id" file exists, removing it
    OK, container 48a25a340a1ceb3d1ee4baa4eafb1b44ad98c6a70bd105f0376cffb2ba21bd2e doesn't run
Finished with the container

[+] Done, see the results
```

Commits providing this feature:
5013bc84e7c6c62163f17b80bc07c14fcd0b5744
9f48f71e00ca36ec329514aa5098594458a7ea53
1b8695f6f6e2179d4e282d540e91a57106fe4ed9
748e1e7dafdad60c025c7f6d08ede681215881d4
68a6801294982536b00a5a731c316c8f139aa3fe
60b8d5e5ce7f2bd55255724d8d26d0a023a606bd


-------------------------------------------------------------------------------

# [\#3 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/3) `closed`: Fail loudly when kernel build fails

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2020-08-12 15:22](https://github.com/a13xp0p0v/kernel-build-containers/issues/3):

Currently it's not very clear when a build fails, as both a failed and a successful builds have the same last few lines:

```
Running the container returned 0
See build log: .../build_log.txt

[+] Done, see the results
```

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-09-14 19:07](https://github.com/a13xp0p0v/kernel-build-containers/issues/3#issuecomment-692253695):

Hi @xairy 
May I ask you to try it now?
Thanks!

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2020-09-14 19:37](https://github.com/a13xp0p0v/kernel-build-containers/issues/3#issuecomment-692269616):

Looks much better now, thanks!

`[+]` at the end is still a bit confusing, but I think this is fine.

```
      LD [M]  fs/nfs/flexfilelayout/nfs_layout_flexfiles.o
      AR      fs/nfs/built-in.a
      AR      fs/built-in.a
    make[1]: Leaving directory '/home/user/out'
    make: *** [Makefile:185: __sub-make] Error 2
Running the container returned 2
See build log: .../build_log.txt

[+] Done, see the results
```

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-09-14 19:46](https://github.com/a13xp0p0v/kernel-build-containers/issues/3#issuecomment-692273984):

This tool can build several kernels during one run (if you specify several compilers with `-c`).
So this `[+] Done` shows that the tool really finished its jobs :)

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2020-09-14 19:48](https://github.com/a13xp0p0v/kernel-build-containers/issues/3#issuecomment-692275298):

OK, SGTM, thank you for the fix! :)


-------------------------------------------------------------------------------

# [\#2 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/2) `closed`: Interrupting kernel build with Ctrl+C doesn't kill all CC processes

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2020-08-10 21:44](https://github.com/a13xp0p0v/kernel-build-containers/issues/2):

The kernel still keeps building in the background. Restarting the build at this point might lead to flaky errors, I assume due to the conflict of two separately running build processes.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-09-14 20:00](https://github.com/a13xp0p0v/kernel-build-containers/issues/2#issuecomment-692281341):

Huh, thank you very much for this report.
I can reproduce it.
Python process is killed by CTRL+C, but the docker container is not:
```
[a13x@hackbase kernel-build-containers]$ sudo docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS              PORTS               NAMES
ccbfcd4f49d3        kernel-build-container:gcc-8   "make O=~/out/ -j5 2…"   7 minutes ago       Up 7 minutes                            zealous_swanson
```
I'll fix it.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-11-02 22:00](https://github.com/a13xp0p0v/kernel-build-containers/issues/2#issuecomment-720748744):

Hi @xairy,

Look how it works now:
```
$ ./make_linux.py -a aarch64 -k ~/develop_local/linux/experiment.config -s ~/develop_local/linux/linux -o ~/develop_local/linux/build_out -c gcc-8 -- -j5
[+] Going to build the Linux kernel for aarch64
[+] Using "/home/a13x/develop_local/linux/experiment.config" as kernel config
[+] Using "/home/a13x/develop_local/linux/linux" as Linux kernel sources directory
[+] Using "/home/a13x/develop_local/linux/build_out" as build output directory
[+] Going to build with: gcc-8
[+] Have additional arguments for 'make': -j5

=== Building with gcc-8 ===
Output subdirectory for this build: /home/a13x/develop_local/linux/build_out/experiment__aarch64__gcc-8
Output subdirectory already exists, use it (no cleaning!)
Copy kconfig to output subdirectory as ".config"
Going to save build log to "build_log.txt" in output subdirectory
Create additional arguments for cross-compilation: ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
Run the container: bash ./start_container.sh gcc-8 /home/a13x/develop_local/linux/linux /home/a13x/develop_local/linux/build_out/experiment__aarch64__gcc-8 -n make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1
    Hey, we gonna use sudo for running docker
    Starting "kernel-build-container:gcc-8"
    Source code directory "/home/a13x/develop_local/linux/linux" is mounted at "~/src"
    Build output directory "/home/a13x/develop_local/linux/build_out/experiment__aarch64__gcc-8" is mounted at "~/out"
    Run docker in NON-interactive mode
    Gonna run "make O=~/out/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j5 2>&1"
    
[sudo] пароль для a13x: 
    make[1]: Entering directory '/home/a13x/out'
      GEN     Makefile
    scripts/kconfig/conf  --syncconfig Kconfig
      GEN     Makefile
      CALL    /home/a13x/src/scripts/atomic/check-atomics.sh
      CALL    /home/a13x/src/scripts/checksyscalls.sh
      CC      arch/arm64/mm/dma-mapping.o
      CHK     include/generated/compile.h
      UPD     include/generated/compile.h
      CC      init/version.o
      CC      kernel/time/alarmtimer.o
      CC      mm/shmem.o
      OBJCOPY arch/arm64/kernel/efi-entry.stub.o
      AR      init/built-in.a
      CC      arch/arm64/net/bpf_jit_comp.o
      CC      arch/arm64/kernel/mte.o
      CC      arch/arm64/mm/extable.o
      CC      kernel/time/posix-timers.o
      CC      arch/arm64/mm/fault.o
^C[!] Got keyboard interrupt, stopping build process...
Kill the container and remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/develop_local/linux/build_out/experiment__aarch64__gcc-8"
    OK, "container.id" file exists, removing it
    Killing the docker container 0463bef60bc7b295dbd9c84a5639693b5dd7768113037d4a8c0bd10e3062ad4c
    0463bef60bc7b295dbd9c84a5639693b5dd7768113037d4a8c0bd10e3062ad4c
    Container 0463bef60bc7b295dbd9c84a5639693b5dd7768113037d4a8c0bd10e3062ad4c is killed
Finished with the container
[!] Early exit
$ sudo docker ps 
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$
```

Do you like it?
Can you try it please?

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2020-11-02 22:07](https://github.com/a13xp0p0v/kernel-build-containers/issues/2#issuecomment-720751608):

Yay, it works! =)

I've noticed a few times that killing `make` manually with `-9` corrupts some kernel build files and the build doesn't finish correctly when restarted. I don't know whether this will be an issue with this approach, I'll report it separately if so. For now I think this is resolved.

Thank you!


-------------------------------------------------------------------------------

# [\#1 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/1) `closed`: Interrupting kernel build with Ctrl+C hangs the terminal

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2020-07-15 23:15](https://github.com/a13xp0p0v/kernel-build-containers/issues/1):

Can be resolved manually with sending a `kill -9` to the `make` process.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2020-07-16 11:32](https://github.com/a13xp0p0v/kernel-build-containers/issues/1#issuecomment-659352362):

Hi @xairy,
I'm glad that you use this tool!
Thanks for the report.

That was a tricky bug: 
`subprocess.Popen()` starts `docker run` with `-it` arguments.
That makes docker run in interactive mode, but breaks the delivery of
`KeyboardInterrupt` in python. So `Ctrl+C` sometimes doesn't work properly.

I added a new `-n` argument for `run_container.sh` to disable docker interactive mode
when needed. I see that the issue is fixed. Can you reproduce it?

#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) commented at [2020-07-16 12:43](https://github.com/a13xp0p0v/kernel-build-containers/issues/1#issuecomment-659386023):

Hi Alex,

Now Ctrl+C works, thanks for the fix and for the tool!


-------------------------------------------------------------------------------

