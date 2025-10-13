FROM ghcr.io/cdloh/alpine:3.20.8@sha256:53420aa54ebbdc1803d094cf2254c25dd942048686aa79e5891811f23dbe2677

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
