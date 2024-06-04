FROM ghcr.io/cdloh/alpine:3.19.1@sha256:ce6180463ada2b89dd39fc59cb934976c77dcf5e5ebb8a17fa160c476c2ea806

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
 && curl -fsSL "https://megatools.megous.com/builds/builds/megatools-${VERSION}-linux-${ARCH}.tar.gz" \
    | tar xzf - -C /tmp \
 && mv "/tmp/megatools-${VERSION}-linux-${ARCH}/megatools" "/usr/local/bin/megatools" \
 && rm -rf "/tmp/megatools-${VERSION}-linux-${ARCH}"

USER kah

CMD ["/usr/local/bin/megatools"]
