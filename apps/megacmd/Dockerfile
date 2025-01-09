FROM ghcr.io/cdloh/alpine:3.20.5@sha256:f09f8fc3660164b6a998131c30675ecf32f4054d89b904e8e56418c58b75da74

ARG VERSION

RUN set -x \
    # Install megatools
 && apk add screen megacmd=${VERSION} --no-cache

USER kah

CMD ["/usr/bin/mega-cmd"]
