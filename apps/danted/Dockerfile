FROM ghcr.io/cdloh/alpine:rolling@sha256:558a6787de60a19575ae73ec6cf6d2f41a41900c2e3053aec1902435344b85c2

ARG VERSION
USER root

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

EXPOSE 1080

CMD ["sockd"]
