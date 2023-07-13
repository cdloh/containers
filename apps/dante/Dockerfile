FROM ghcr.io/cdloh/alpine:3.18.2@sha256:bc77ba9976d0b784daea3f2fb60eca5c6c984896958ddceecb337d2bd2e28e5e

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
