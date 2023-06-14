FROM ghcr.io/cdloh/alpine:3.17.4@sha256:063ec4426b3cc4b49a516f4111c21621a31214eef9a3321118b8fdf3e8c8dc6b

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
