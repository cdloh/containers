FROM ghcr.io/cdloh/alpine:3.20.7@sha256:92eeecc11704135b7f0140860bc8dd3235c9098ceae1d2021bf01da59523a5de

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV QBITTORRENT__PORT=8080 \
    QBITTORRENT__BT_PORT=50413

#hadolint ignore=DL3018
RUN \
    apk add --no-cache ca-certificates geoip p7zip python3 \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community qt6-qtbase-sqlite

RUN \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH="x86_64" ;; \
        'linux/arm64') export ARCH="aarch64" ;; \
    esac \
    && \
    case "${CHANNEL}" in \
        'stable') \
            export RELEASE=$(curl -sL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -r '. | "release-\(.qbittorrent)_v\(.libtorrent_1_2)"') \
            && curl -fsSL -o /app/qbittorrent-nox "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${RELEASE}/${ARCH}-qbittorrent-nox" \
        ;; \
        'beta') \
            export RELEASE=$(curl -sL "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/dependency-version.json" | jq -r '. | "release-\(.qbittorrent)_v\(.libtorrent_2_0)"') \
            && curl -fsSL -o /app/qbittorrent-nox "https://github.com/userdocs/qbittorrent-nox-static/releases/download/${RELEASE}/${ARCH}-qbittorrent-nox" \
        ;; \
    esac \
    && \
    chown -R root:root /app/qbittorrent-nox \
    && chmod -R 755 /app/qbittorrent-nox \
    && rm -rf /tmp/*

USER kah

COPY ./apps/qbittorrent/config.py /scripts/config.py
COPY ./apps/qbittorrent/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/qbittorrent/qBittorrent"
