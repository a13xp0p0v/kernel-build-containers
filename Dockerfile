ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}.04 as base

ARG GCC_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo aptitude flex bison libncurses5-dev make git exuberant-ctags bc libssl-dev \
    gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-plugin-dev gcc g++ libelf-dev \
    && apt-get -y autoremove

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g ${GID} -o ${UNAME} && \
    useradd -u $UID -g $GID -G sudo -ms /bin/bash ${UNAME} && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${UNAME}
WORKDIR /home/${UNAME}/src
