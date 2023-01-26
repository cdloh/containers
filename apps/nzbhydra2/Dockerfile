FROM ghcr.io/cdloh/alpine:3.17.0@sha256:a65cb479579a14541da68c650eabbabf0f26c969921bfceefbe246c7a6a4ff9b

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates openjdk17-jre-headless python3
#hadolint ignore=DL3018,DL3059
RUN \
    curl -fsSL -o /tmp/nzbhydra2.zip \
        "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-generic.zip" \
    && unzip -q /tmp/nzbhydra2.zip -d /app \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

USER kah
COPY ./apps/nzbhydra2/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/theotherp/nzbhydra2"
