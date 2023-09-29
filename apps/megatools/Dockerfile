FROM ghcr.io/cdloh/alpine:3.18.4@sha256:a79ac39db9318bfd402f3830b92a24930498d6261445547e10a39b3789c7b30f

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
