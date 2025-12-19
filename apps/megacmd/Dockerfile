FROM ghcr.io/cdloh/alpine:3.20.8@sha256:866800239e9d5fbd7bb7bcb0c1a54b2ab56b9db6c97cc020d6cb1a46fb44f4b4

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
