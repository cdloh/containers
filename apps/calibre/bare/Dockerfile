FROM ghcr.io/cdloh/ubuntu:jammy-20260210.1@sha256:925ed3c1d6f6744442c2141fa3fe6fbb65c893783db9d17b09ae418e538f6899 as buildstage

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
        xz-utils \
    && \
    mkdir -p /opt/calibre \
    && \
    curl -fsSL "https://download.calibre-ebook.com/${VERSION}/calibre-${VERSION}-${ARCH}.txz" \
        | tar Jxvf - -C /app \
    && chown -R root:root /app \
    && chmod -R 755 /app


## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /app /

LABEL org.opencontainers.image.source="https://github.com/kovidgoyal/calibre"
