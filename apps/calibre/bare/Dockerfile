FROM ghcr.io/cdloh/ubuntu:jammy-20231004@sha256:f2dd5c332b98d302d7222b41255b0677db02a48a4f656e0416b951f6c49108b3 as buildstage

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
