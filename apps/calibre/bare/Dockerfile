FROM ghcr.io/cdloh/ubuntu:rolling@sha256:a98473c93cbef5a95d382818c30781d6a8a775ee7e7f6dcb5074be396dd5a950 as buildstage

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
        | tar Jxvf - -C /opt/calibre \
    && chown -R root:root /opt/calibre \
    && chmod -R 755 /opt/calibre


## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /opt/calibre /