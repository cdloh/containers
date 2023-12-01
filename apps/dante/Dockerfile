FROM ghcr.io/cdloh/alpine:3.18.5@sha256:c1f952eeeb5d1522d755be7383de48f8e1d29749ae800e671183a7245f18f868

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
