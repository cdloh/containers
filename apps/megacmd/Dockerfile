FROM ghcr.io/cdloh/alpine:3.20.7@sha256:92eeecc11704135b7f0140860bc8dd3235c9098ceae1d2021bf01da59523a5de

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
