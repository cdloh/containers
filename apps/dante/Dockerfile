FROM ghcr.io/cdloh/alpine:rolling@sha256:ff764e599f4cd1c8e547a1ae33844df40509bcc0d4bd8522b0c05f0508bb5c7f

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
