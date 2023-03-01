FROM ghcr.io/cdloh/alpine:3.17.2@sha256:9da12aa352b644a39cb02e7d5082956d9a71c5acbc3a984aac058f2b7a1a483f

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
