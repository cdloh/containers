FROM ghcr.io/cdloh/alpine:3.20.1@sha256:cc69eca0ef2d4ad14fb75e20d33ce92b1901a9b00979a77d393e892d244d706d

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
