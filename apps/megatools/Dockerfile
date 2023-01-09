FROM ghcr.io/cdloh/alpine:3.17.0@sha256:a65cb479579a14541da68c650eabbabf0f26c969921bfceefbe246c7a6a4ff9b

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
