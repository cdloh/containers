FROM ghcr.io/cdloh/ubuntu:jammy-20250619@sha256:6022cea286428a606690528c8f62b8aec8d3c837b5f5127929c8e494f1f84a47

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
