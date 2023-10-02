FROM ghcr.io/cdloh/alpine:3.18.4@sha256:a79ac39db9318bfd402f3830b92a24930498d6261445547e10a39b3789c7b30f as build
ARG TARGETARCH
ARG VERSION
WORKDIR /tmp
ENV LDFLAGS="-static"
RUN \
    apk add --no-cache \
        autoconf \
        automake \
        build-base \
        curl \
        linux-headers \
        musl-dev \
    && \
    curl -fsSL "https://github.com/animetosho/par2cmdline-turbo/archive/refs/tags/v${VERSION}.tar.gz" \
        | tar xzf - -C /tmp --strip-components 1 \
    && ./automake.sh \
    && ./configure \
    && make \
    && make install

FROM ghcr.io/cdloh/alpine:3.18.4@sha256:a79ac39db9318bfd402f3830b92a24930498d6261445547e10a39b3789c7b30f
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
