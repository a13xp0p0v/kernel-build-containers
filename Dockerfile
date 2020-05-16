ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as base

ARG GCC_VERSION
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
      sudo aptitude flex bison libncurses5-dev make git exuberant-ctags bc libssl-dev \
      gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev gcc g++ libelf-dev \
    && apt-get -y autoremove

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g ${GID} -o ${UNAME} && \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME} && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 && \
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100

USER ${UNAME}
WORKDIR /home/${UNAME}/src
