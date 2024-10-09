ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as base

ARG GCC_VERSION
ARG CLANG_VERSION
RUN set -ex; \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y -q apt-utils dialog; \
    apt-get install -y -q sudo aptitude flex bison cpio libncurses5-dev make git exuberant-ctags sparse bc libssl-dev libelf-dev bsdmainutils dwarves xz-utils; \
    if [ "$GCC_VERSION" ]; then \
      apt-get install -y -q gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev \
        gcc-${GCC_VERSION}-aarch64-linux-gnu g++-${GCC_VERSION}-aarch64-linux-gnu \
        gcc-${GCC_VERSION}-arm-linux-gnueabi g++-${GCC_VERSION}-arm-linux-gnueabi; \
      if [ "$GCC_VERSION" != "4.9" ]; then \
        apt-get install -y -q gcc-${GCC_VERSION}-plugin-dev-aarch64-linux-gnu gcc-${GCC_VERSION}-plugin-dev-arm-linux-gnueabi; \
      fi; \
      update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/arm-linux-gnueabi-gcc arm-linux-gnueabi-gcc /usr/bin/arm-linux-gnueabi-gcc-${GCC_VERSION} 100; \
      update-alternatives --install /usr/bin/arm-linux-gnueabi-g++ arm-linux-gnueabi-g++ /usr/bin/arm-linux-gnueabi-g++-${GCC_VERSION} 100; \
    fi; \
    if [ "$CLANG_VERSION" ]; then \
      apt-get install -y -q clang-${CLANG_VERSION} lld-${CLANG_VERSION} clang-tools-${CLANG_VERSION}; \
      update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100; \
      update-alternatives --install /usr/bin/lld lld /usr/bin/lld-${CLANG_VERSION} 100; \
    fi

ARG UNAME
ARG UID
ARG GID
RUN set -ex; \
    userdel -r `getent passwd ${UID} | cut -d : -f 1` > /dev/null 2>&1; \
    groupdel -f `getent group ${GID} | cut -d : -f 1` > /dev/null 2>&1; \
    groupadd -g ${GID} -o ${UNAME}; \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME}; \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
    echo "Set disable_coredump false" >> /etc/sudo.conf;

USER ${UNAME}
WORKDIR /home/${UNAME}/src

CMD ["bash"]
