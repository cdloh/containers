FROM ghcr.io/cdloh/ubuntu:jammy-20250415.1@sha256:36dd7bc3d99906e3b9d08e4f44911bbf02280482dacf16833c3cb6652dc70420

ARG TARGETPLATFORM
ARG VERSION

ENV CALIBRE__CREATE_LIBRARY="true" \
    CALIBRE__LIBRARY="/config" \
    CALIBRE__PORT="8080"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') \
            export ARCH='x86_64'; \
        ;; \
        'linux/arm64') \
            export ARCH='arm64'; \
        ;; \
    esac \
    && \
    apt-get -qq update \
    && \
    apt-get -qq install -y \
        libegl1 \
        libfontconfig1 \
        libgl1-mesa-glx \
        libopengl0 \
        libxdamage1 \
        libxkbcommon0 \
        python3 \
        xz-utils \
    && \
    mkdir -p /opt/calibre \
    && \
    curl -fsSL "https://download.calibre-ebook.com/${VERSION}/calibre-${VERSION}-${ARCH}.txz" \
        | tar Jxvf - -C /app \
    && /app/calibre_postinstall \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
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
COPY ./apps/calibre/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/kovidgoyal/calibre"
