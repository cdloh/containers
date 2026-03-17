FROM ghcr.io/cdloh/ubuntu:jammy-20260217@sha256:e5e3e20fece3b7efcb09d16ef9d42c0f051a1fcdc5cc6b443b3f579de84ee1de

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
