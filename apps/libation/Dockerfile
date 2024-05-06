FROM ghcr.io/cdloh/ubuntu:jammy-20240416@sha256:4c58a201387d4680fce07d947efffd17119e580a38fffb7bda51761a8b9645e2

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3059
RUN \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='amd64' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && \
    mkdir -p /app/bin \
    && \
    curl -fsSL "https://github.com/rmcrackan/Libation/releases/download/v${VERSION}/Libation.${VERSION}-linux-chardonnay-${ARCH}.deb" -o /app/libation.deb \
    && dpkg -i libation.deb \
    && rm libation.deb \
    && rm -rf /tmp/*

USER kah


RUN /usr/bin/libationcli version
CMD ["/usr/bin/libationcli"]


LABEL org.opencontainers.image.source="https://github.com/rmcrackan/Libation"