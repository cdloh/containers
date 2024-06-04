FROM ghcr.io/cdloh/alpine:3.20.0@sha256:28e5b08b2b5565061e7ac71ec8a5a04a57257e42c49eee1a6ffa7115c385a281

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
