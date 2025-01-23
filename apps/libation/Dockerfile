FROM ghcr.io/cdloh/ubuntu:jammy-20240911.1@sha256:f2907c3774d09ae4d1f2f625cb9f5d6496837538ee1c30f0a9867b5608cae5c9

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
