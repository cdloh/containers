FROM ghcr.io/cdloh/alpine:3.19.0@sha256:99cd9b1b7f9ef6e9f95c3f408caafa2f100c4e4dffafaba636e0c98fb1b9f04f

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH:-amd64}

ENV RTORRENT__DEFAULT_CONFIG="true" \
    RTORRENT__DEFAULT_SOCKET="true" \
    RTORRENT__DEFAULT_PORT="true" \
    RTORRENT__CONFIG_FILE="/config/rtorrent.rc" \
    RTORRENT__SOCKET="/sock/rtorrent.sock" \
    RTORRENT__BT_PORT="50415"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates
#hadolint ignore=DL3059
RUN curl -fsSL -o /app/rtorrent \
        "https://github.com/jesec/rtorrent/releases/download/v${VERSION}/rtorrent-linux-${TARGETARCH}" \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && mkdir -p "$(dirname "${RTORRENT__SOCKET}")" \
    && chown -R kah:kah "$(dirname "${RTORRENT__SOCKET}")" \
    && chmod -R 775 "$(dirname "${RTORRENT__SOCKET}")" \
    && rm -rf /tmp/*

USER kah
COPY ./apps/rtorrent/rtorrent.rc /app/rtorrent.rc
COPY ./apps/rtorrent/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/jesec/rtorrent"
