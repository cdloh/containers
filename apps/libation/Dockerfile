FROM ghcr.io/cdloh/ubuntu:jammy-20250714@sha256:bd0f9c4e1a42d1f4a645ba0bd1ab74f75d23b1db458641f9f5160454ac4106f8

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
