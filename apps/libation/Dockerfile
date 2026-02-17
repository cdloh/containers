FROM ghcr.io/cdloh/ubuntu:jammy-20260210.1@sha256:925ed3c1d6f6744442c2141fa3fe6fbb65c893783db9d17b09ae418e538f6899

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


COPY ./apps/libation/appsettings.json /app/Libation/Settings.json
RUN /usr/bin/libationcli version
CMD ["/usr/bin/libationcli", "version"]


LABEL org.opencontainers.image.source="https://github.com/rmcrackan/Libation"
