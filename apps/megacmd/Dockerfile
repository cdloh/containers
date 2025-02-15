FROM ghcr.io/cdloh/alpine:3.20.6@sha256:7a601294220717136760820967fa54b7194c12abd9f0a9afd3cc33122f0712ff

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
