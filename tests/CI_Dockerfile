FROM busybox:1.36

ARG CLANG_VERSION
ARG GCC_VERSION
ARG UBUNTU_VERSION
ARG UID
ARG GID

# Different build args are needed for different image IDs
RUN printf '%s\n' \
		"clang=${CLANG_VERSION}" \
		"gcc=${GCC_VERSION}" \
		"ubuntu=${UBUNTU_VERSION}" \
		> /build-id

USER ${UID}:${GID}
WORKDIR /src