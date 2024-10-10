FROM ghcr.io/cdloh/alpine:3.20.3@sha256:e1fb78c6c398db9356454b832e3b03ab8b74976b8f0b30309ae709e6b8e1ea43

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
