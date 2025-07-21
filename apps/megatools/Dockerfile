FROM ghcr.io/cdloh/alpine:3.20.7@sha256:92eeecc11704135b7f0140860bc8dd3235c9098ceae1d2021bf01da59523a5de

ARG VERSION

RUN set -x \
 && \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') \
            export ARCH='x86_64'; \
        ;; \
        'linux/arm64') \
            export ARCH='aarch64'; \
        ;; \
    esac \
    # Install megatools
 && curl -fsSL "https://xff.cz/megatools/builds/builds/megatools-${VERSION}-linux-${ARCH}.tar.gz" \
    | tar xzf - -C /tmp \
 && mv "/tmp/megatools-${VERSION}-linux-${ARCH}/megatools" "/usr/local/bin/megatools" \
 && rm -rf "/tmp/megatools-${VERSION}-linux-${ARCH}"

USER kah

CMD ["/usr/local/bin/megatools"]
