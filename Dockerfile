# syntax=docker/dockerfile:1.4
ARG UBUNTU_VERSION=default
FROM ubuntu:${UBUNTU_VERSION} AS base

RUN --mount=type=cache,target=/var/cache/apt \
    set -ex; \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y -q --no-install-recommends apt-utils dialog; \
    apt-get install -y -q --no-install-recommends sudo aptitude flex bison cpio libncurses5-dev make git exuberant-ctags sparse bc libssl-dev libelf-dev bsdmainutils dwarves xz-utils zstd gawk rsync; \
    apt-get install -y -q --no-install-recommends python3 python3-venv; \
    apt-get install -y -q --no-install-recommends python-is-python3 || apt-get install -y -q --no-install-recommends python

ARG GCC_VERSION
RUN --mount=type=cache,target=/var/cache/apt \
    set -ex; \
    if [ "$GCC_VERSION" ]; then \
      apt-get install -y -q --no-install-recommends gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev \
        gcc-${GCC_VERSION}-aarch64-linux-gnu g++-${GCC_VERSION}-aarch64-linux-gnu \
        gcc-${GCC_VERSION}-arm-linux-gnueabi g++-${GCC_VERSION}-arm-linux-gnueabi; \
      if [ "$GCC_VERSION" != "4.9" ]; then \
        apt-get install -y -q --no-install-recommends gcc-${GCC_VERSION}-plugin-dev-aarch64-linux-gnu gcc-${GCC_VERSION}-plugin-dev-arm-linux-gnueabi; \
      fi; \
      if [ "$GCC_VERSION" != "4.9" ] && [ "$GCC_VERSION" != "5" ] && [ "$GCC_VERSION" != "6" ]; then \
        apt-get install -y -q --no-install-recommends gcc-${GCC_VERSION}-riscv64-linux-gnu g++-${GCC_VERSION}-riscv64-linux-gnu gcc-${GCC_VERSION}-plugin-dev-riscv64-linux-gnu; \
      fi; \
      update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/arm-linux-gnueabi-gcc arm-linux-gnueabi-gcc /usr/bin/arm-linux-gnueabi-gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/arm-linux-gnueabi-g++ arm-linux-gnueabi-g++ /usr/bin/arm-linux-gnueabi-g++-${GCC_VERSION} 100; \
      if [ "$GCC_VERSION" != "4.9" ] && [ "$GCC_VERSION" != "5" ] && [ "$GCC_VERSION" != "6" ]; then \
        update-alternatives --install /usr/bin/riscv64-linux-gnu-gcc riscv64-linux-gnu-gcc /usr/bin/riscv64-linux-gnu-gcc-${GCC_VERSION} 100; \
        update-alternatives --install /usr/bin/riscv64-linux-gnu-g++ riscv64-linux-gnu-g++ /usr/bin/riscv64-linux-gnu-g++-${GCC_VERSION} 100; \
      fi; \
    fi

ARG CLANG_VERSION
RUN --mount=type=cache,target=/var/cache/apt \
    set -ex; \
    if [ "$CLANG_VERSION" ]; then \
      if [ "$CLANG_VERSION" = "5" ] || [ "$CLANG_VERSION" = "6" ]; then \
        CLANG_VERSION="${CLANG_VERSION}.0"; \
        apt-get install -y -q clang-${CLANG_VERSION} lld-${CLANG_VERSION} clang-tools-6.0; \
      else \
        apt-get install -y -q clang-${CLANG_VERSION} lld-${CLANG_VERSION} clang-tools-${CLANG_VERSION}; \
      fi; \
      if [ "$CLANG_VERSION" != "5.0" ] && [ "$CLANG_VERSION" != "6.0" ]; then \
        update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-${CLANG_VERSION} 100; \
        update-alternatives --install /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-${CLANG_VERSION} 100; \
      fi; \
      update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/lld lld /usr/bin/lld-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/llvm-readelf llvm-readelf /usr/bin/llvm-readelf-${CLANG_VERSION} 100; \
    fi

ARG UNAME
ARG UID
ARG GNAME
ARG GID
RUN set -x; \
    # These commands are allowed to fail (it happens for root, for example).
    # The result will be checked in the next RUN.
    userdel -r `getent passwd ${UID} | cut -d : -f 1` > /dev/null 2>&1; \
    groupdel -f `getent group ${GID} | cut -d : -f 1` > /dev/null 2>&1; \
    groupadd -g ${GID} ${GNAME}; \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME}; \
    mkdir /src; \
    chown -R ${UNAME}:${GNAME} /src; \
    mkdir /out; \
    chown -R ${UNAME}:${GNAME} /out; \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${UNAME}:${GNAME}
WORKDIR /src

RUN set -ex; \
    id | grep "uid=${UID}(${UNAME}) gid=${GID}(${GNAME})"; \
    sudo ls; \
    pwd | grep "^/src"; \
    touch /src/test; \
    rm /src/test; \
    touch /out/test; \
    rm /out/test

CMD ["bash"]
