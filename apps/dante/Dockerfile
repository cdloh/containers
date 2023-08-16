FROM ghcr.io/cdloh/alpine:3.18.3@sha256:8416f7ff758e0f0ab4e66f085b9d4dcb3dc75bf3ed1e7243156cd83456dfcbd1

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
