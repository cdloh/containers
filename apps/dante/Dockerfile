FROM ghcr.io/cdloh/alpine:3.17.1@sha256:9e9b5c2416682a4305d7fdbf5914f0e1834df969e8f62401163bffeec3f49339

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
