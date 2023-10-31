FROM ghcr.io/cdloh/alpine:3.18.4@sha256:7aaedc72028b5310e79cbd47175e52395fa78c6d6ee2b250dd83a5805d00fe97

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
