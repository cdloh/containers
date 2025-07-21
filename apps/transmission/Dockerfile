FROM ghcr.io/cdloh/alpine:3.20.7@sha256:92eeecc11704135b7f0140860bc8dd3235c9098ceae1d2021bf01da59523a5de

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV HOME=/config \
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config \
    TRANSMISSION__RPC_PORT=9091 \
    TRANSMISSION_WEB_HOME=/app/web

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates geoip p7zip python3 \
    transmission-cli~"${VERSION}" transmission-daemon~"${VERSION}"

#hadolint ignore=DL3059
RUN chown -R root:root /usr/bin/transmission* \
    && chmod -R 755 /usr/bin/transmission* \
    && ln -s /usr/bin/transmission-cli /app/transmission-cli \
    && ln -s /usr/bin/transmission-daemon /app/transmission-daemon \
    && ln -s /usr/share/transmission/public_html /app/web \
    && rm -rf /tmp/*

USER kah
COPY ./apps/transmission/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/transmission/transmission"
