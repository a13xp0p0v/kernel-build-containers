ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as base

ARG GCC_VERSION
ARG CLANG_VERSION
RUN set -x && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y -q apt-utils dialog && \
    apt-get install -y -q sudo aptitude flex bison libncurses5-dev make git exuberant-ctags bc libssl-dev libelf-dev && \
    if [ "$GCC_VERSION" ]; then \
      apt-get install -y -q gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev gcc g++ \
        gcc-${GCC_VERSION}-aarch64-linux-gnu g++-${GCC_VERSION}-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu g++-aarch64-linux-gnu && \
      if [ "$GCC_VERSION" != "4.9" ]; then \
        apt-get install -y -q gcc-${GCC_VERSION}-plugin-dev-aarch64-linux-gnu; \
      fi \
    fi; \
    if [ "$CLANG_VERSION" ]; then \
      apt-get install -y -q clang-${CLANG_VERSION} lld-${CLANG_VERSION} clang-tools-${CLANG_VERSION} clang lld; \
    fi

ARG UNAME
ARG UID
ARG GID
RUN set -x && groupadd -g ${GID} -o ${UNAME} && \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME} && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    if [ "$GCC_VERSION" ]; then \
      sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 && \
      sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 && \
      sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-${GCC_VERSION} 100 && \
      sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-${GCC_VERSION} 100; \
    fi; \
    if [ "$CLANG_VERSION" ]; then \
      sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100 && \
      sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100; \
    fi

USER ${UNAME}
WORKDIR /home/${UNAME}/src

CMD ["bash"]
