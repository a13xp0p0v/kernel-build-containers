ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as base

ARG GCC_VERSION
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
      sudo aptitude flex bison libncurses5-dev make git exuberant-ctags bc libssl-dev \
      gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev gcc g++ libelf-dev && \
    if [ "$GCC_VERSION" != "4.8" ]; \
    then \
      apt-get install -y --no-install-recommends \
        gcc-${GCC_VERSION}-aarch64-linux-gnu g++-${GCC_VERSION}-aarch64-linux-gnu \
        gcc-${GCC_VERSION}-plugin-dev-aarch64-linux-gnu gcc-aarch64-linux-gnu g++-aarch64-linux-gnu; \
    fi

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g ${GID} -o ${UNAME} && \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME} && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 && \
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 && \
    if [ "$GCC_VERSION" != "4.8" ]; \
    then \
      sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-${GCC_VERSION} 100 && \
      sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-${GCC_VERSION} 100 ; \
    fi

USER ${UNAME}
WORKDIR /home/${UNAME}/src
