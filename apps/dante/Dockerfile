FROM ghcr.io/cdloh/alpine:3.17.2@sha256:8957fe63b9aa81da940c448b757c0b02dbebfeef93daa2cdc3c8a387a962b2df

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
