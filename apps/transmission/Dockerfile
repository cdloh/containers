FROM ghcr.io/cdloh/alpine:3.20.1@sha256:cc69eca0ef2d4ad14fb75e20d33ce92b1901a9b00979a77d393e892d244d706d

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
