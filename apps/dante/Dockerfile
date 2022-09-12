FROM ghcr.io/cdloh/alpine:rolling@sha256:1eadc37a841913fe56e08b0e1bbaa8b087cb27d9a9eca2f9b553224b3b752c75

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
