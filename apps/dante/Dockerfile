FROM ghcr.io/cdloh/alpine:3.20.9@sha256:ce4c95822b5b212101aea53e94985a6b8802b540cac5b48296b015f800a5c233

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
