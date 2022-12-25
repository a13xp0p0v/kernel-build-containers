Export of Github issues for [a13xp0p0v/kernel-build-containers](https://github.com/a13xp0p0v/kernel-build-containers).

# [\#9 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/9) `open`: Investigate support for menuconfig
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/4965052?u=9504acb2f9ed05c2433d88e75ff083a609a1c38f&v=4" width="50">[xairy](https://github.com/xairy) opened issue at [2022-09-08 20:56](https://github.com/a13xp0p0v/kernel-build-containers/issues/9):

It would be nice if `menuconfig` worked via the `./make_linux.py` script.




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

# [\#6 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/6) `open`: Support building Rocky Linux RPM packages with custom patches
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/8112328?u=9954d624746e15481703860242325306b076fbe7&v=4" width="50">[vogelfreiheit](https://github.com/vogelfreiheit) opened issue at [2022-05-17 01:31](https://github.com/a13xp0p0v/kernel-build-containers/issues/6):

I'm opening this to remind myself that I should clean up the modifications I have made to use rpmbuilder for building el8 RPM packages.

The only catch is I'm going the patching manually, in the spec file.

#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2022-05-31 00:04](https://github.com/a13xp0p0v/kernel-build-containers/issues/6#issuecomment-1141548137):

Hi @vogelfreiheit,

I'm looking forward to testing your pull request.


-------------------------------------------------------------------------------

# [\#5 Issue](https://github.com/a13xp0p0v/kernel-build-containers/issues/5) `open`: Unprivileged container support
**Labels**: `enhancement`


#### <img src="https://avatars.githubusercontent.com/u/8112328?u=9954d624746e15481703860242325306b076fbe7&v=4" width="50">[vogelfreiheit](https://github.com/vogelfreiheit) opened issue at [2022-05-17 01:30](https://github.com/a13xp0p0v/kernel-build-containers/issues/5):

Hi,

I have adapted the code to use a -cap_all and non privileged user + immutable filesystem to build the kernels.
However, I have not adapted make_linux.py to support it yet. I'm adding this as a reminder, if I have some time to prepare the code and send it over, or if you wish to implement it your own way.



#### <img src="https://avatars.githubusercontent.com/u/1419667?u=de82e29061c3ef5f1c19f95528f8a82b08051fd2&v=4" width="50">[a13xp0p0v](https://github.com/a13xp0p0v) commented at [2022-05-31 00:04](https://github.com/a13xp0p0v/kernel-build-containers/issues/5#issuecomment-1141548076):

Hi @vogelfreiheit,

I'm looking forward to testing your pull request.


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

