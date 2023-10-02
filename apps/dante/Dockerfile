FROM ghcr.io/cdloh/alpine:3.18.4@sha256:a79ac39db9318bfd402f3830b92a24930498d6261445547e10a39b3789c7b30f

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
