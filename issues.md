Export of Github issues for [a13xp0p0v/kernel-build-containers](https://github.com/a13xp0p0v/kernel-build-containers).

# [\#40 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/40) `open`: fix(Dockerfile): `llvm-strip` and `llvm-objcopy` does not exists for clang-5,6
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) opened issue at [2025-10-05 04:44](https://github.com/a13xp0p0v/kernel-build-containers/pull/40):

hello, @a13xp0p0v !

while installing ancient containers (clang-5,6) the error occured:
```
249.8 + update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-5.0 100
249.8 update-alternatives: error: alternative path /usr/bin/llvm-strip-5.0 doesn't exist
```
llvm-strip-6, llvm-objcopy-5,6 doesn't exists as well, so i decided to drop these packages out

what do you think about this choice?

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-10-18 21:25](https://github.com/a13xp0p0v/kernel-build-containers/pull/40#issuecomment-3418828290):

@d1sgr4c3, thank you for fixing this!

Could you please double-check that building all containers is successful now?

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-10-21 05:12](https://github.com/a13xp0p0v/kernel-build-containers/pull/40#issuecomment-3424698492):

yeah, i ran  [test_image_mgmt.sh](https://github.com/a13xp0p0v/kernel-build-containers/blob/master/test_image_mgmt.sh)

all tests succeed, including building all images via `-b all`


-------------------------------------------------------------------------------

# [\#39 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/39) `open`: podman runtime support implemented
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) opened issue at [2025-07-19 08:51](https://github.com/a13xp0p0v/kernel-build-containers/pull/39):

according to https://github.com/a13xp0p0v/kernel-build-containers/issues/31

in this work i implemented a podman image runtime support for kernel-build-containers.
now we can choose image runtime via `-p` or `-d` flags. moreover, this commit introduces
a way to choose runtime image engine without specifying flag `-p` or `-d` directly. bash
scripts written with strict flag logic.

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-19 08:52](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3092181762):

hello, @a13xp0p0v 

please have a look at my work

i also left some comments to make your review work easier

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-19 08:59](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3092189589):

@a13xp0p0v, please take a look at `README.md `

i edited the readme with minimal changes. please take a look and tell me which of my new features should i show there?

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-19 15:33](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3092413688):

Hello @d1sgr4c3!

That's cool, thank you!

I'll take a closer look at this pull request on some free weekend.

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-22 14:22](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3102971037):

cant wait for your review!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-26 20:13](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3123183969):

Hi @d1sgr4c3, I have some time to look at your work this weekend.

Could you please rebase this branch onto the fresh `master` and also give me the ability to push commits into it?

Thanks!

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-27 14:16](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3124447596):

hello, @a13xp0p0v 

rebased my branch right now. also i checked this mark

<img width="297" height="194" alt="image" src="https://github.com/user-attachments/assets/af43574a-bf37-4d06-bc53-bb0914540869" />

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-08-30 21:11](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3239543414):

Hello @d1sgr4c3!

I've done some work with this pull request:

1. I rebased this branch onto the fresh `master`.
2. I reordered the commits: the commits that I ask you to rework are now at the top of this branch.
3. I simplified your new code in `manage_images.py` and `start_container.sh`. Please see my commits.

Let's improve this branch further. Could you please do the following?

1. Please change `build_linux.py` similarly to `manage_images.py`.
2. Please change `finish_container.sh` similarly to `start_container.sh`.
3. Please improve the argument order: `finish_container.sh podman/docker kill/nokill out_dir`.
4. Please rework the top commits that modify the tests.
5. Please fix the top commit changing the `README` according to the new usage.

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-10-25 08:13](https://github.com/a13xp0p0v/kernel-build-containers/pull/39#issuecomment-3446183761):

@a13xp0p0v, i tried to do all carefully, make commits atomically and simplify review itertions

what i did:
1. changes `build_linux.py` similarly to `manage_images.py`
2. the same with `start_container.sh` by idea of `finish_container.sh`
3. improved the argument order: `finish_container.sh podman/docker kill/nokill out_dir`
4. rebased on top of my fix #40  (which is on top of master)
5. reworked test absolutely
6. slightly update the readme


-------------------------------------------------------------------------------

# [\#38 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/38) `merged`: fix: bad links for `llvm` and `lld` if `package-` installed
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) opened issue at [2025-07-19 06:13](https://github.com/a13xp0p0v/kernel-build-containers/pull/38):

this pull request should fix #37 

Co-authored-by: Willenst <willenst@gmail.com>

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-19 15:20](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3092406552):

Hello @d1sgr4c3 and @Willenst,

I've checked this in the `clang-16` container: the `lld-16` and `llvm-16` packages are already installed.
<img width="960" height="252" alt="image" src="https://github.com/user-attachments/assets/0827e046-f783-4fea-a72a-0654c0be1bb4" />
 
Installing these packages without specifying the needed version causes the installation of a wrong version (unfortunately):
<img width="1410" height="359" alt="image" src="https://github.com/user-attachments/assets/47aabdb2-fcbc-41f4-9005-0c781f00dc15" />

I guess the only thing we need is adding the `update-alternatives` command for the needed tools.

@d1sgr4c3, please try your kernel compilation after adding this single line to the Dockerfile:
```
update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/lld-${CLANG_VERSION} 100; \
```
Does it work fine?

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-22 14:12](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3102930194):

@a13xp0p0v, thnaks for your reply

unfortunately, there is a bunch of problems with `llvm` package -- there is more over 100 tools and we need this one too

```
  CC       /src/tools/objtool/pager.o
  CC       /src/tools/objtool/parse-options.o
  CC       /src/tools/objtool/run-command.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/file2alias.o
  CC       /src/tools/objtool/sigchain.o
  HOSTCC  scripts/mod/sumversion.o
  CC       /src/tools/objtool/subcmd-config.o
  LD       /src/tools/objtool/arch/x86/objtool-in.o
  LD       /src/tools/objtool/libsubcmd-in.o
  AR       /src/tools/objtool/libsubcmd.a
/bin/sh: 1: llvm-ar: not found
make[3]: *** [Makefile:62: /src/tools/objtool/libsubcmd.a] Error 127
make[2]: *** [Makefile:66: /src/tools/objtool/libsubcmd.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/x86/kernel/asm-offsets.s
  LD       /src/tools/objtool/objtool-in.o
make[1]: *** [Makefile:68: objtool] Error 2
make: *** [Makefile:1948: tools/objtool] Error 2
make: *** Waiting for unfinished jobs....
  CALL    scripts/checksyscalls.sh
d@483e1249eac8:/src$
```

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-22 14:18](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3102954408):

i also rebased my branch!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-26 16:06](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3122098852):

Ok, @d1sgr4c3, thanks for the info!

In that case, I think we should add `update-alternatives` for the necessary tools from the `llvm` package one by one.

In fact, we should avoid using the command `apt-get install llvm` because it installs the **wrong version** of the package and unnecessarily increases the size of the container images.

Could you please try building it again and add the necessary `update-alternatives` to the Dockerfile?

I suppose that the kernel compilation will not require all the available binaries from the package.

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-26 17:49](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3122183142):

> In that case, I think we should add update-alternatives for the necessary tools from the llvm package one by one.

there is 100+ utilities in `llvm` packages... 

are you sure? ofc i can make that byt i thought that it will be unreadable

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-26 18:16](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3122196272):

> are you sure? ofc i can make that byt i thought that it will be unreadable

No, @d1sgr4c3, not all of them of course.

I mean adding only those that are needed for building the Linux kernel with `make LLVM=1`.
You may try the compilation, see the errors, and add `update-alternatives` only for the necessary ones.

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-27 14:18](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3124449065):

okay. as far as i know it expands as
```
make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
  ```
  
 a bit later i will complete this PR

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-08-27 07:43](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3227154485):

hello, @a13xp0p0v !
with that fix i was able to build the linux kernel with `LLM=1` env variable

i set all necessary bins with update-alternatives as you asked

```diff
diff --git a/Dockerfile b/Dockerfile
index 5e4b38c..cfe7e14 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -41,6 +41,13 @@ RUN set -ex; \
       update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100; \
       update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100; \
       update-alternatives --install /usr/bin/lld lld /usr/bin/lld-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/lld-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-${CLANG_VERSION} 100; \
+      update-alternatives --install /usr/bin/llvm-readelf llvm-readelf /usr/bin/llvm-readelf-${CLANG_VERSION} 100; \
     fi

 ARG UNAME
 ```
 please, can you verify this PR again?

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-08-30 12:11](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3239224462):

Hello @d1sgr4c3. Thanks for the improvements!

I've found one error, see the fix: https://github.com/a13xp0p0v/kernel-build-containers/pull/38/commits/0c0371ce47ece52c7a42475775e4dd3ac0bb8730.

And by the way I've fixed two warnings in `docker build`: https://github.com/a13xp0p0v/kernel-build-containers/pull/38/commits/8b75845edfbbd7f304d1313e8d2e00b3b603d746.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-08-30 12:14](https://github.com/a13xp0p0v/kernel-build-containers/pull/38#issuecomment-3239226074):

`make LLVM=1` for the Linux kernel sources works fine now.

Merged!


-------------------------------------------------------------------------------

# [\#37 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/37) `closed`: `llvm` and `lld` wierd behavior
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) opened issue at [2025-07-16 04:39](https://github.com/a13xp0p0v/kernel-build-containers/issues/37):

hello, @a13xp0p0v 
thank you for the really grat tool

recently i tried to build containter OS (cos) and found this

```
d@c8eb62a7a1c8:/src/exploit_env/drill$ make mrproper
d@c8eb62a7a1c8:/src/exploit_env/drill$ cp config .config
d@c8eb62a7a1c8:/src/exploit_env/drill$ make LLVM=1 -j16
  SYNC    include/config/auto.conf.cmd
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/Kconfig.include:40: linker 'ld.lld' not found
make[2]: *** [scripts/kconfig/Makefile:71: syncconfig] Error 1
make[1]: *** [Makefile:603: syncconfig] Error 2
make: *** [Makefile:712: include/config/auto.conf.cmd] Error 2
d@c8eb62a7a1c8:/src/exploit_env/drill$ sudo apt install llvm lld
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  llvm-runtime
The following NEW packages will be installed:
  lld llvm llvm-runtime
0 upgraded, 3 newly installed, 0 to remove and 8 not upgraded.
Need to get 10.1 kB of archives.
After this operation, 137 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu jammy/universe amd64 lld amd64 1:14.0-55~exp2 [3178 B]
Get:2 http://archive.ubuntu.com/ubuntu jammy/universe amd64 llvm-runtime amd64 1:14.0-55~exp2 [3204 B]
Get:3 http://archive.ubuntu.com/ubuntu jammy/universe amd64 llvm amd64 1:14.0-55~exp2 [3758 B]
Fetched 10.1 kB in 11s (883 B/s)
Selecting previously unselected package lld:amd64.
(Reading database ... 32905 files and directories currently installed.)
Preparing to unpack .../lld_1%3a14.0-55~exp2_amd64.deb ...
Unpacking lld:amd64 (1:14.0-55~exp2) ...
Selecting previously unselected package llvm-runtime:amd64.
Preparing to unpack .../llvm-runtime_1%3a14.0-55~exp2_amd64.deb ...
Unpacking llvm-runtime:amd64 (1:14.0-55~exp2) ...
Selecting previously unselected package llvm.
Preparing to unpack .../llvm_1%3a14.0-55~exp2_amd64.deb ...
Unpacking llvm (1:14.0-55~exp2) ...
Setting up lld:amd64 (1:14.0-55~exp2) ...
Setting up llvm-runtime:amd64 (1:14.0-55~exp2) ...
Setting up llvm (1:14.0-55~exp2) ...
d@c8eb62a7a1c8:/src/exploit_env/drill$ make LLVM=1 -j16
  SYNC    include/config/auto.conf.cmd
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  [...]
```
i tried to build [COS](https://cos.googlesource.com/third_party/kernel/+archive/ccbab0481cec29d7f07947bcb6255f325b88513f.tar.gz) and this happened

#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) commented at [2025-07-16 06:48](https://github.com/a13xp0p0v/kernel-build-containers/issues/37#issuecomment-3077126185):

```
Setting up clang-6.0 (1:6.0-1ubuntu2~16.04.1) ...
Setting up clang-tools-6.0 (1:6.0-1ubuntu2~16.04.1) ...
Setting up libffi-dev:amd64 (3.2.1-4) ...
Setting up llvm-6.0-runtime (1:6.0-1ubuntu2~16.04.1) ...
mount: permission denied
update-binfmts: warning: Couldn't mount the binfmt_misc filesystem on /proc/sys/fs/binfmt_misc.
Setting up llvm-6.0 (1:6.0-1ubuntu2~16.04.1) ...
Setting up llvm-6.0-dev (1:6.0-1ubuntu2~16.04.1) ...
Setting up lld-6.0 (1:6.0-1ubuntu2~16.04.1) ...
Setting up libomp5:amd64 (3.7.0-3) ...
Setting up libomp-dev (3.7.0-3) ...
```
in fact, this packages are installed... pretty strange


-------------------------------------------------------------------------------

# [\#36 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/36) `merged`: Support Building selftests

#### <img src="https://avatars.githubusercontent.com/u/24351757?u=ed1f82517d3498a3dacf368b6827e76ce60a370a&v=4" width="50">[vpetrog](https://github.com/vpetrog) opened issue at [2025-07-13 22:13](https://github.com/a13xp0p0v/kernel-build-containers/pull/36):

From 3d355ae78bfe8e3c777bac800ac3bc9165dfb68c Mon Sep 17 00:00:00 2001
From: Evangelos Petrongonas <vpetrog@ieee.org>
Date: Mon, 14 Jul 2025 00:27:21 +0200
Subject: [PATCH 0/2] ***Support building Selftests***

When working with linux, kernel headers are often required when building out of tree modules or various userspace components, or the kernel selftests.

This patchset adds support building linux selftests by extending the docker containers to include the rsync utilinig, which is neccessary for installing the headers and removing the manual shell redirection of `stderr` to `stdout`, which was polluting  the `make` arguments. It is handled instead via the, already existing, `Popen` `stderr=..` argument.

Evangelos Petrongonas (2):
  Dockerfile: Add rsync to the container
  build_linux: Remove manual shell redirection

```
 Dockerfile     | 2 +-
 build_linux.py | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
```
-- 
2.50.1



#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-19 14:47](https://github.com/a13xp0p0v/kernel-build-containers/pull/36#issuecomment-3092389042):

Hello @vpetrog, 

Thanks for the excellent contribution!

1) I've checked that `make headers_install` works fine now:
    <img width="960" height="581" alt="image" src="https://github.com/user-attachments/assets/ccf564a9-151d-4955-ba7f-86eda51d8629" />

2) I've tested the kernel selftests, which now can be built:
    <img width="1920" height="782" alt="image" src="https://github.com/user-attachments/assets/ec027d7e-f587-4da0-afe0-f975bfd8e0e1" />

3) And I've checked that stderr output is still collected correctly. To do that, I tried a wrong build target:
  ```
$ ./build_linux.py -c gcc-14 -a x86_64 -s ~/develop_local/linux-stable/linux-stable/ -o ~/develop_local/linux-stable/linux-stable/ -- wat
[+] Going to build the Linux kernel for x86_64
[+] Using "/home/a13x/develop_local/linux-stable/linux-stable/" as Linux kernel sources directory
[+] Using "/home/a13x/develop_local/linux-stable/linux-stable/" as build output directory
[+] Going to build with: gcc-14
[+] Have additional arguments for 'make': wat
[+] Going to run 'make' on 6 CPUs

=== Building with gcc-14 ===
Output subdirectory for this build: /home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14
Output subdirectory already exists, use it (no cleaning!)
No kconfig to copy to output subdirectory
Going to save build log to "build_log.txt" in output subdirectory
Run the container: bash /home/a13x/land/develop/Linux_Kernel/kernel-build-containers/start_container.sh gcc-14 /home/a13x/develop_local/linux-stable/linux-stable/ /home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14 -n -- make O=../out/ -j 6 wat
    Hey, we gonna use sudo for running docker
    Run docker in NON-interactive mode
    Starting "kernel-build-container:gcc-14"
    Mount source code directory "/home/a13x/develop_local/linux-stable/linux-stable/" at "/src"
    Mount build output directory "/home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14" at "/out"
    Gonna run command "make O=../out/ -j 6 wat"
    
    make[1]: Entering directory '/out'
    make[2]: *** No rule to make target 'wat'.  Stop.
    make[1]: Leaving directory '/out'
    make[1]: *** [/src/Makefile:224: __sub-make] Error 2
    make: *** [Makefile:224: __sub-make] Error 2
The container returned 2
Finish building the kernel
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14"
    OK, "container.id" file exists, removing it
    OK, container ef835e0d937d5b7fdd199bc1d56224b2dbbe24f86926c477c5a8878da9b077c5 doesn't run
The finish_container.sh script returned 0
See the build log: /home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14/build_log.txt

[+] Done, see the results
  ```
  And then insured that the build log contains the stderr output:
  ```
$ cat /home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14/build_log.txt
Hey, we gonna use sudo for running docker
Run docker in NON-interactive mode
Starting "kernel-build-container:gcc-14"
Mount source code directory "/home/a13x/develop_local/linux-stable/linux-stable/" at "/src"
Mount build output directory "/home/a13x/develop_local/linux-stable/linux-stable//x86_64__gcc-14" at "/out"
Gonna run command "make O=../out/ -j 6 wat"

make[1]: Entering directory '/out'
make[2]: *** No rule to make target 'wat'.  Stop.
make[1]: Leaving directory '/out'
make[1]: *** [/src/Makefile:224: __sub-make] Error 2
make: *** [Makefile:224: __sub-make] Error 2
  ```

Thank you! Merged.


-------------------------------------------------------------------------------

# [\#35 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/35) `merged`: Image managment improvements

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2025-07-04 11:33](https://github.com/a13xp0p0v/kernel-build-containers/pull/35):

Hi, I have done some work on improving image management. First of all I added the ability to delete single containers based on this request #32 and tried to do it somehow more compatible with podman #31. Also, I thought it would be cool to add and remove multiple images at a time and add the ability to use the `-b` and `-r` flags without arguments to work with `all` images by default: kind of user comfortability features. Covered new code with tests and updated the REAME. As a bonus, I worked a bit on code readability, waiting for your review!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-08 12:42](https://github.com/a13xp0p0v/kernel-build-containers/pull/35#issuecomment-3048798218):

Hello @Willenst!

Thanks for the contribution!

I've encountered some issues during the review. Let's improve this!

1. Let's drop the last commit with the style changes. Some of the changes don't fit PEP 8 (https://peps.python.org/pep-0008/). Moreover, they increase the final diff and make review harder.
2. Let's drop the `all` argument for `build` and `remove`. It makes the code more complicated. We can simply build/remove all images if `-b`/`-r` options go without any argument.
3. Let's separate the changes into independent commits:
   - Check that there is no running containers that use a given image during the image removal
   - Drop the `all` argument from the current implementation
   - Add an ability to remove a single image (make `-r` work similar to `-b`)
   - Add ability to add/remove multiple images
   - Improve the test
   - Update the readme

Looking forward to the next version! Thanks!

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2025-07-08 13:32](https://github.com/a13xp0p0v/kernel-build-containers/pull/35#issuecomment-3048991619):

Hello @a13xp0p0v!

Thanks for feedback!

I've force pushed, and here is new vision of implementation, closed for what you advised but with a bit of changes:
1. I've dropped style changes
2. `all` argument is removed but in one of the last commits
3. Now changes looks like this:
- Check that there is no running containers that use a given image during the image removal (included a bit of extra code for podman comparability)
- Add an ability to remove a single image (make -r work similar to -b)
- Add UI ability to work without `all` argument (now `-r` and `-b` works like `-r all` and `-b all`
- Add ability to add/remove multiple images
- Completely drop the `all` argument from the current implementation
- Improve the test
- Update the readme

this approach is a bit easier to implement step by step.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-11 11:58](https://github.com/a13xp0p0v/kernel-build-containers/pull/35#issuecomment-3062013589):

Hello @Willenst, thanks for a nice prototype!

I've reviewed it carefully and found out that using `nargs='*'` from argparse breaks the beauty of the code, unfortunately. It's not worth it.

So I took everything except the ability to add/remove multiple images at once.

I also added some fixes and improvements.

I'll finish testing, check the coverage and then merge this branch.


-------------------------------------------------------------------------------

# [\#34 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/34) `closed`: Add RISC-V support
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-03-22 15:20](https://github.com/a13xp0p0v/kernel-build-containers/issues/34):

This is needed for https://github.com/a13xp0p0v/kernel-hardening-checker/pull/172

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-03-22 17:52](https://github.com/a13xp0p0v/kernel-build-containers/issues/34#issuecomment-2745385819):

Done!


-------------------------------------------------------------------------------

# [\#33 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/33) `closed`: Add python and other packages that are needed for building Linux (for example, for`allmodconfig`)
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-01-11 17:45](https://github.com/a13xp0p0v/kernel-build-containers/issues/33):

Thanks to @xairy for the idea.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-11 17:46](https://github.com/a13xp0p0v/kernel-build-containers/issues/33#issuecomment-2585354925):

Also thanks to @gatlinnewhouse for the idea.

#### <img src="https://avatars.githubusercontent.com/u/10749793?u=b7d6626a124ad705d4aa338b4215e5c2275742f7&v=4" width="50">[gatlinnewhouse](https://github.com/gatlinnewhouse) commented at [2025-01-11 17:54](https://github.com/a13xp0p0v/kernel-build-containers/issues/33#issuecomment-2585357062):

My fork isn't actively maintained but I'd love to see allmodconfig added here! It helped me test enabling `-Wrestrict` by default.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-06-15 11:48](https://github.com/a13xp0p0v/kernel-build-containers/issues/33#issuecomment-2973704025):

Hello!

I've installed Gawk and Python to enable building the Linux kernel with allmodconfig:
tested successfully for `Linux 6.15.2` and `gcc-14`.

For old Ubuntu containers without the `python-is-python3` package, the `python` virtual package is installed instead.

Closing this issue.


-------------------------------------------------------------------------------

# [\#32 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/32) `closed`: Add ability to remove a single container
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-01-05 11:28](https://github.com/a13xp0p0v/kernel-build-containers/issues/32):

Thanks @xairy for the idea.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-07-11 16:39](https://github.com/a13xp0p0v/kernel-build-containers/issues/32#issuecomment-3062979011):

Solved in #35, thanks @Willenst.

Now we can build and remove a single container image:
```
$ python3 manage_images.py -b gcc-12
```
and
```
python3 manage_images.py -r gcc-12
```


-------------------------------------------------------------------------------

# [\#31 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/31) `open`: Add podman support
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-01-02 21:11](https://github.com/a13xp0p0v/kernel-build-containers/issues/31):






-------------------------------------------------------------------------------

# [\#30 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/30) `open`: Add Clang 18 support
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-01-02 21:10](https://github.com/a13xp0p0v/kernel-build-containers/issues/30):






-------------------------------------------------------------------------------

# [\#29 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/29) `closed`: Support building the Linux kernel in the source code directory (without `O=` option)
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2025-01-02 21:04](https://github.com/a13xp0p0v/kernel-build-containers/issues/29):



#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-10-17 21:38](https://github.com/a13xp0p0v/kernel-build-containers/issues/29#issuecomment-3417315993):

Done!

For in-place building of Linux at the root of the kernel source tree, you can either:
 - Specify the same `-s` and `-o` path without `-k`,
 - Or simply run the tool without `-o` and `-k` arguments.

```console
$ python3 build_linux.py -c clang-16 -a x86_64 -s ~/linux-stable/linux-stable -- defconfig
Going to build the Linux kernel for x86_64
Going to build with clang-16
Using "/home/a13x/linux-stable/linux-stable" as Linux kernel sources directory
Have additional arguments for 'make': defconfig
Going to run 'make' on 6 CPUs
No '-k' and '-o' arguments; skip creating an output subdirectory to allow in-place build
Output subdirectory for this build: /home/a13x/linux-stable/linux-stable
Output subdirectory already exists, use it (no cleaning!)
No kconfig to copy to the output subdirectory
Going to write the build log to "/home/a13x/linux-stable/linux-stable/build_log.txt"
Going to build the kernel in-place (without 'O=')
Add arguments for compiling with clang: CC=clang
Run the container: bash /home/a13x/kernel-build-containers/start_container.sh clang-16 /home/a13x/linux-stable/linux-stable /home/a13x/linux-stable/linux-stable -n -- make CC=clang -j 6 defconfig
    Hey, we gonna use sudo for running docker
    Run docker in NON-interactive mode
    Starting "kernel-build-container:clang-16"
    Mount source code directory "/home/a13x/linux-stable/linux-stable" at "/src"
    Mount build output directory "/home/a13x/linux-stable/linux-stable" at "/out"
    Gonna run command "make CC=clang -j 6 defconfig"
    
      HOSTCC  scripts/basic/fixdep
      HOSTCC  scripts/kconfig/conf.o
...
    *** Default configuration is based on 'x86_64_defconfig'
    #
    # configuration written to .config
    #
The container returned 0
Finish building the kernel
Only remove the container id file:
    Hey, we gonna use sudo for running docker
    Search "container.id" file in build output directory "/home/a13x/linux-stable/linux-stable"
    OK, "container.id" file exists, removing it
    OK, container 17e85692f36973a4e641fd5052bd2f33ce7d1f9f76ea8a73893b557f395d80cc doesn't run
The finish_container.sh script returned 0
See the build log: /home/a13x/linux-stable/linux-stable/build_log.txt
[+] Done, see the results
```


-------------------------------------------------------------------------------

# [\#28 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/28) `closed`: Make group checking more rigorous
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-10-21 14:13](https://github.com/a13xp0p0v/kernel-build-containers/issues/28):

An unlikely scenario, but still possible, is the presence of the word docker in the group name

![image](https://github.com/user-attachments/assets/4750c5bc-e098-4401-ac1f-de6cdda41c44)


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-10-26 17:48](https://github.com/a13xp0p0v/kernel-build-containers/issues/28#issuecomment-2439671829):

I've fixed it in https://github.com/Willenst/kernel-build-containers/commit/c93a0be3db732b38fc30c729649bc7dc88029d83

Will pull it later.

Thanks for finding this bug!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-02 20:54](https://github.com/a13xp0p0v/kernel-build-containers/issues/28#issuecomment-2568365609):

Fixed in #27 (merged into `master`).


-------------------------------------------------------------------------------

# [\#27 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/27) `merged`: Add manage_containers.py

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-10-17 12:03](https://github.com/a13xp0p0v/kernel-build-containers/pull/27):

Hello, it looks like my previous PR #22 was broken, so here is its recovery

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-10-26 21:47](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2439746272):

Hello @Willenst,

Thanks for your work!

I've added some fixes (including one for #28) and some style improvements.

Currently, I see a possible problem:
I think `Container.check()` should make sure that there is a single container with this pair of compilers.
That would make the code less error-prone.
What do you think about that?

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-11-09 15:28](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2466257811):

Hi @Willenst,

Could you please also reorder clang and gcc in the `--list` output?

I've added some fixes in `make_linux.py` and renamed it to `build_linux.py`.
It will allow better command autocompletion.

Now you can remove the obsolete shell scripts (because we have `manage_containers.py`). 

And please update the whole README.

Thanks for the collaboration! 👍

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-11-11 09:52](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2467697745):

Hello @a13xp0p0v.

I decided to reorder clang and gcc pretty much everywhere to achieve uniformity, I hope I didn't overdo it. 

Also removed “obsolete” shell scripts and updated README for them and for changes in python scripts.

I also added a couple of beauty features to the README, like text and subparagraph highlights, I hope it will look better this way.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-11-30 21:00](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2509358546):

Hi @Willenst,

Please see the improvements that I've pushed (I've fixed a bug in your `Reorder gcc and clang in build_linux.py` commit).

It looks like the `Container.rm()` method currently may give wrong results for running containers. Please check it carefully.

And please run your functional tests again.

Thank you!

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-12-02 13:34](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2511560758):

Hello @a13xp0p0v!

I fixed the bug with running containers in `Container.rm()`, found a way to pull them directly from the docker without any regulars or greps.

I also demolished Ubuntu 23, it was recently permanently removed from the repositories. 

While poking around in the docker, I came to the conclusion that I need to redo all the naming, because the code actually builds images, not containers, the container is already a directly isolated environment with an image, so I made a global change of names. I ask you to evaluate my changes, after that I can update `README.md` to the current state of the code.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-12-08 21:52](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2526399073):

Hello @Willenst,

Please see my commits with the improvements.
BTW, I've removed a lot of code :)

Does it work for you?

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-12-09 19:51](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2529279799):

Hi, @a13xp0p0v !

Thanks for your cool improvements, unfortunately they messed up the tests a bit, but I fixed them. I also found that it is possible to improve the coverage of the tests a bit - implemented this fix. 

Next, I've done a bit of work on the textarea in the code itself, I've also added a small error message output (in case of trying to delete a working container, I hope this will be useful for novice users). 

I also updated the README, I think the moment has come and I decided to revise it now.

Next, I've done a bit of work on the textarea in the code itself, I've also added a small error message output (in case of trying to delete a working container, I hope this will be useful for novice users). 

I also updated the README, I think the moment has come and I decided to revise it now.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-02 20:49](https://github.com/a13xp0p0v/kernel-build-containers/pull/27#issuecomment-2568359966):

Hi @Willenst,
I've finished this pull request and merged the branch (you can see a bunch of commits on top). 
Thanks for the collaboration.
Happy New Year!


-------------------------------------------------------------------------------

# [\#26 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/26) `closed`: Troubles with enormous docker cache
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-10-16 08:11](https://github.com/a13xp0p0v/kernel-build-containers/issues/26):

`Build Cache     142       0         74.82GB   74.82GB`

it would be nice to add a flag for clearing the cache.


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-02 20:53](https://github.com/a13xp0p0v/kernel-build-containers/issues/26#issuecomment-2568364213):

I didn't manage to reproduce this issue.
By the way, what happens if you run
```
sudo docker rmi $(sudo docker images -f "dangling=true" -q)
```
or
```
python3 manage_images.py -r
```
?

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2025-01-09 10:46](https://github.com/a13xp0p0v/kernel-build-containers/issues/26#issuecomment-2579812848):

Hi, you can check the build cache with the command:

 `docker system df`

The commands you mentioned delete the images but not the cache itself, the cache is basically all the data used to build the images. For example, we are building a container image based on `ubuntu 22`, after deleting the image, the `ubuntu 22` files themselves will still be stored, more info about this here:

https://docs.docker.com/build/cache/

You can prune the cache with the command: 

`docker builder prune`

The main problem - it will delete all the build cache, not just created by our scripts. In general there is a system of filtering by using timestamps and labels of the containers themselves, but for this you need to distribute labels to them. This requires a somewhat tricky approach so as not to harm people working with containers. 

The main problem here is that if we conditionally change the build commands inside a Python script, change the tags, change the dockerfile, the old cache can often be preserved, I don't know the exact conditions for its preservation yet, but if we change the build processes in the future, the end user may start to have a huge cache, I think it's a kind of maliciousness :)

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-11 17:42](https://github.com/a13xp0p0v/kernel-build-containers/issues/26#issuecomment-2585353793):

> You can prune the cache with the command:
>
> docker builder prune
>
> The main problem - it will delete all the build cache, not just created by our scripts. 

I agree, we should not delete the cache without user's consent.

I looked at the documentation at https://docs.docker.com/build/cache/garbage-collection/.
The garbage is collected automatically. So I guess we should do nothing with it.
Quoting:
```
Garbage Collection (GC) runs periodically and follows an ordered list of prune policies.

The BuildKit daemon clears the build cache when the cache size becomes too big, or when the cache age expires.

For most users, the default GC behavior is sufficient and doesn't require any intervention.
```

Thank you!
Closing for now.


-------------------------------------------------------------------------------

# [\#25 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/25) `closed`: Dockerfile refactor

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-10-02 13:06](https://github.com/a13xp0p0v/kernel-build-containers/pull/25):

Hi, I decided to refactor the Dockerfile a bit, I think the update-alternatives part can be moved to the package installation block, that way no additional "if" checks below need to be called. It would also simplify the code structure a bit.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-10-09 06:58](https://github.com/a13xp0p0v/kernel-build-containers/pull/25#issuecomment-2401490779):

Hello @Willenst,

I've made some refactoring of the Dockerfile.

I used `set -e` to get rid of those messy `&&`.

Your idea is included in 72bc9a7a4d21f3f84453d2242031cfb3b5bc039c.

Thank you!


-------------------------------------------------------------------------------

# [\#24 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/24) `merged`: add xz-utils package
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/121037831?u=fc711d33e89e67f8ad3094527177769eba26ba18&v=4" width="50">[d1sgr4c3](https://github.com/d1sgr4c3) opened issue at [2024-09-20 06:53](https://github.com/a13xp0p0v/kernel-build-containers/pull/24):

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

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-17 12:15](https://github.com/a13xp0p0v/kernel-build-containers/pull/23):

Hello, I've decided to add dwarves package to the apt-get package list in Dockerfile. I think this package must be added alongside with cpio, which is mentioned here #20, because it is required to build many kernels with debian kconfig (which is a really popular one I suppose).

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-18 20:16](https://github.com/a13xp0p0v/kernel-build-containers/pull/23#issuecomment-2359326928):

Thank you!
Merged.


-------------------------------------------------------------------------------

# [\#22 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/22) `closed`: Add manage_containers.py

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-13 17:07](https://github.com/a13xp0p0v/kernel-build-containers/pull/22):

Hello, I've decided to make a python script for these issues #12 #13 

So, here is python script, documentation, tests, and some additions for old clangs support in Dockerfile and make_linux.py!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-30 18:10](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2383858986):

Hello @Willenst,

Thanks for your work!

Please see some notes below.

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-10-02 13:13](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2388613956):

Also rebased on this PR

https://github.com/a13xp0p0v/kernel-build-containers/pull/25/files

 and refactored a bit my dockerfile

https://github.com/a13xp0p0v/kernel-build-containers/commit/d57f88ccdd7c0800993351b1279e653c06b42f3b

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-10-09 20:18](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2403354810):

Re-based on current PR, answered for all conversations, waiting for next review!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-10-12 19:27](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2408668725):

Hello @Willenst,

Unfortunately, this branch is broken in multiple places.

1) Please check it once again after the commit https://github.com/a13xp0p0v/kernel-build-containers/pull/22/commits/9b1c4b9e93ca608fd5b39379d89462bc0ad4e142

There are things like this:
```
  File "./manage_containers.py", line 124
    print(f'\n{'Ubuntu':<6} | {'GCC':<6} | {'Clang':<6} | {'Status':<6}')
                ^
SyntaxError: invalid syntax
```

It can be fixed this way:
```
 def list_containers(containers):
     """Print built containers"""
-    print(f'\n{'Ubuntu':<6} | {'GCC':<6} | {'Clang':<6} | {'Status':<6}')
+    print(f'\n{"Ubuntu":<6} | {"GCC":<6} | {"Clang":<6} | {"Status":<6}')
```

2) An empty sudo wrapper is broken (if the current user is in the `docker` group):
```
$ ./manage_containers.py -a gcc-10
Adding Ubuntu-20.04 container with GCC-10 and Clang-11
Traceback (most recent call last):
  File "./manage_containers.py", line 183, in <module>
    main()
  File "./manage_containers.py", line 173, in main
    add_containers(args.add, containers)
  File "./manage_containers.py", line 109, in add_containers
    c.add()
  File "./manage_containers.py", line 61, in add
    subprocess.run([self.sudo_wrapper, 'docker', 'build', *build_args, '.'],
  File "/usr/lib/python3.8/subprocess.py", line 493, in run
    with Popen(*popenargs, **kwargs) as process:
  File "/usr/lib/python3.8/subprocess.py", line 858, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib/python3.8/subprocess.py", line 1704, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
PermissionError: [Errno 13] Permission denied: ''
```

Also, could you please reorganize the commits in this branch after fixing those bugs.

Thanks you so much for your work!

#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) commented at [2024-10-14 16:38](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2411752213):

Hello @a13xp0p0v, thanks a lot for guiding me through this PR! It seems like the reason for the first crash was old Python. I adapted the code for it and also fixed it to work properly for the `docker` group. Additionally, I added some checks into the tests! I'm waiting for your review to start squashing commits!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-10-16 08:16](https://github.com/a13xp0p0v/kernel-build-containers/pull/22#issuecomment-2416058893):

@Willenst, nice. I think it's time to rearrange the commits.
Thanks!


-------------------------------------------------------------------------------

# [\#21 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/21) `merged`: Update Dockerfile for optimisation and old clang
**Labels**: `bug`


#### <img src="https://avatars.githubusercontent.com/u/67371653?u=f5d8536b55c751c2bdb6358897d72523a01006a2&v=4" width="50">[Willenst](https://github.com/Willenst) opened issue at [2024-09-13 16:57](https://github.com/a13xp0p0v/kernel-build-containers/pull/21):

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

#### <img src="https://avatars.githubusercontent.com/u/14011921?v=4" width="50">[mkchauras](https://github.com/mkchauras) opened issue at [2024-09-04 09:27](https://github.com/a13xp0p0v/kernel-build-containers/pull/19):

This patch supports build for ppc64le arch

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-04 15:07](https://github.com/a13xp0p0v/kernel-build-containers/pull/19#issuecomment-2329322183):

Hello @mchauras-linux,

May I ask why did you close this pull request?

Thanks!

#### <img src="https://avatars.githubusercontent.com/u/14011921?v=4" width="50">[mkchauras](https://github.com/mkchauras) commented at [2024-09-13 06:10](https://github.com/a13xp0p0v/kernel-build-containers/pull/19#issuecomment-2348110176):

This still doesn't support ppc arch, it only has support for ppc64le.
If you feel this is enough I can reopen this. But it still lacks support for ppc64 and ppc


-------------------------------------------------------------------------------

# [\#18 PR](https://github.com/a13xp0p0v/kernel-build-containers/pull/18) `merged`: Give user a choice to choose which container to build

#### <img src="https://avatars.githubusercontent.com/u/14011921?v=4" width="50">[mkchauras](https://github.com/mkchauras) opened issue at [2024-09-04 09:22](https://github.com/a13xp0p0v/kernel-build-containers/pull/18):

Created a fucntion for every container build, user passes the argument and builds only the version user asked for.
This saves a lot of time and space on the disk

If no arguments are provided all the containers will be built. I kept it that way since I didn't wanna change the legacy behaviour.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-29 14:56](https://github.com/a13xp0p0v/kernel-build-containers/pull/18#issuecomment-2381388396):

Hello @mchauras-linux,

Thanks for your work!

I've improved your pull request a bit: 
https://github.com/a13xp0p0v/kernel-build-containers/commit/566cbb3cfb9904069d55f69afecea7053906a2e1
https://github.com/a13xp0p0v/kernel-build-containers/commit/8b01459311dfd2d776ecc20fcaed465e4515edcd
https://github.com/a13xp0p0v/kernel-build-containers/commit/94f5befec69f7b097e63c3a3f27ca86775959e52

Merged!

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2024-09-29 15:01](https://github.com/a13xp0p0v/kernel-build-containers/pull/18#issuecomment-2381390007):

By the way, there is a pull request #22 by @Willenst, implementing `manage_containers.py`.

It will provide additional functionality.


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

# [\#13 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/13) `closed`: Stop/Remove all running containers before removing images
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2023-10-04 21:11](https://github.com/a13xp0p0v/kernel-build-containers/issues/13):

Thanks to @joseigor for the PoC: https://github.com/a13xp0p0v/kernel-build-containers/pull/11

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-11-17 12:34](https://github.com/a13xp0p0v/kernel-build-containers/issues/13#issuecomment-1816337349):

Looked at the design.

Decided to create a python script `manage_containers.py`, that will substitute `build_containers.sh` and `rm_containers.sh`.

It will support choosing specific containers for removing.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-02 20:59](https://github.com/a13xp0p0v/kernel-build-containers/issues/13#issuecomment-2568370246):

Implemented in #27.

Quoting [README](https://github.com/a13xp0p0v/kernel-build-containers?tab=readme-ov-file#how-to-remove-the-created-container-images):

__Remove all created images:__
```
$ python3 manage_images.py -r
```

__Expected output, if some containers are running:__
```
Remove the container image providing Clang 17 and GCC 14
Error response from daemon: conflict: unable to delete 18f5a5c70571 (cannot be forced) - image is being used by running container e322f234ee1b
[!] WARNING: Image removal failed, see the error message above

[!] WARNING: failed to remove 1 container image(s), see the log above

Current status:
-----------------------------------------
 Ubuntu | Clang  | GCC    | Image ID
-----------------------------------------
 16.04  | 5      | 4.9    | -
 16.04  | 6      | 5      | -
 18.04  | 7      | 6      | -
 18.04  | 8      | 7      | -
 20.04  | 9      | 8      | -
 20.04  | 10     | 9      | -
 20.04  | 11     | 10     | -
 22.04  | 12     | 11     | -
 22.04  | 13     | 12     | -
 22.04  | 14     | 12     | -
 24.04  | 15     | 13     | -
 24.04  | 16     | 14     | -
 24.04  | 17     | 14     | 18f5a5c70571
-----------------------------------------
```
In that case simply stop this container and run `manage_images.py -r` again.


-------------------------------------------------------------------------------

# [\#12 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/12) `closed`: Allow the user to choose a specific version of the container image to build
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) opened issue at [2023-10-04 21:10](https://github.com/a13xp0p0v/kernel-build-containers/issues/12):

Thanks to @joseigor for the PoC: #11

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2023-11-17 12:33](https://github.com/a13xp0p0v/kernel-build-containers/issues/12#issuecomment-1816335617):

Looked at the design.

Decided to create a python script `manage_containers.py`, that will substitute `build_containers.sh` and `rm_containers.sh`.

It will support choosing specific containers.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2025-01-02 20:50](https://github.com/a13xp0p0v/kernel-build-containers/issues/12#issuecomment-2568360802):

Implemented in #27.


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

