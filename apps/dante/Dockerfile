FROM ghcr.io/cdloh/alpine:3.17.0@sha256:7d4b2a50b637a844c0c8c1b7c3b4399a1450822bf0eae081ef45549410c60201

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
