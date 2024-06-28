FROM ghcr.io/cdloh/ubuntu:jammy-20240530@sha256:e7cee9800dc018ec8def5f88852d506aa6efb9f6040c5208586c21e9e0cedc09

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
    mkdir -p /app/Libation \
    && chown -R kah:kah /app/Libation \
    && \
    curl -fsSL "https://github.com/rmcrackan/Libation/releases/download/v${VERSION}/Libation.${VERSION}-linux-chardonnay-${ARCH}.deb" -o /app/libation.deb \
    && dpkg -i libation.deb \
    && rm libation.deb \
    && rm -rf /tmp/*

USER kah


RUN /usr/bin/libationcli version
COPY ./apps/libation/appsettings.json /app/Libation/appsettings.json
CMD ["/usr/bin/libationcli"]


LABEL org.opencontainers.image.source="https://github.com/rmcrackan/Libation"
