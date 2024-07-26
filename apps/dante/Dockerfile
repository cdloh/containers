FROM ghcr.io/cdloh/alpine:3.20.2@sha256:07dc32191d1e9ff5274df1bb33a662afed92147d30c1eb0bcbeea11641026e06

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
