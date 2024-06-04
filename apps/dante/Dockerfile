FROM ghcr.io/cdloh/alpine:3.19.1@sha256:ce6180463ada2b89dd39fc59cb934976c77dcf5e5ebb8a17fa160c476c2ea806

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
