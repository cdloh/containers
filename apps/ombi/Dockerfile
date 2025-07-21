FROM ghcr.io/cdloh/ubuntu:jammy-20250714@sha256:bd0f9c4e1a42d1f4a645ba0bd1ab74f75d23b1db458641f9f5160454ac4106f8

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

# hadolint ignore=DL3008,DL3015,SC2039,SC2086
RUN \
    apt-get -qq update \
    && \
    apt-get -qq install -y \
        libicu70 \
    && \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='x64' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && \
    curl -fsSL "https://github.com/Ombi-app/Ombi/releases/download/v${VERSION}/linux-${ARCH}.tar.gz" \
        | tar xzf - -C /app \
    && \
    apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/ \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

USER kah
COPY ./apps/ombi/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/Ombi-app/Ombi"
