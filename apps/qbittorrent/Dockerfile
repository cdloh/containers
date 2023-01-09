FROM ghcr.io/cdloh/alpine:3.17.1@sha256:9e9b5c2416682a4305d7fdbf5914f0e1834df969e8f62401163bffeec3f49339

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV QBITTORRENT__PORT=8080 \
    QBITTORRENT__BT_PORT=50413

#hadolint ignore=DL3018
RUN \
    apk add --no-cache ca-certificates geoip p7zip python3 \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community qt6-qtbase-sqlite qbittorrent-nox~"${VERSION}"
#hadolint ignore=DL3059
RUN chown -R root:root /usr/bin/qbittorrent-nox \
    && chmod -R 755 /usr/bin/qbittorrent-nox \
    && ln -s /usr/bin/qbittorrent-nox /app/qbittorrent-nox \
    && rm -rf /tmp/*

USER kah

COPY ./apps/qbittorrent/config.py /scripts/config.py
COPY ./apps/qbittorrent/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/qbittorrent/qBittorrent"
