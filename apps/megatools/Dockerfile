FROM ghcr.io/cdloh/alpine:3.20.8@sha256:866800239e9d5fbd7bb7bcb0c1a54b2ab56b9db6c97cc020d6cb1a46fb44f4b4

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
