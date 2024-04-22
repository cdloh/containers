FROM ghcr.io/cdloh/ubuntu:jammy-20240405@sha256:c25bc3d769a17eef3780520278fe958a3fb5bec907012e94ae57487e290ad259

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
