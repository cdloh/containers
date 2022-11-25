FROM ghcr.io/cdloh/alpine:3.17.0@sha256:7d4b2a50b637a844c0c8c1b7c3b4399a1450822bf0eae081ef45549410c60201

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates openjdk11-jre-headless python3
#hadolint ignore=DL3018,DL3059
RUN \
    curl -fsSL -o /tmp/nzbhydra2.zip \
        "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-linux.zip" \
    && unzip -q /tmp/nzbhydra2.zip -d /app \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

USER kah
COPY ./apps/nzbhydra2/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/theotherp/nzbhydra2"
