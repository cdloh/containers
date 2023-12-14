FROM ghcr.io/cdloh/alpine:3.19.0@sha256:99cd9b1b7f9ef6e9f95c3f408caafa2f100c4e4dffafaba636e0c98fb1b9f04f as build
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

FROM ghcr.io/cdloh/alpine:3.19.0@sha256:99cd9b1b7f9ef6e9f95c3f408caafa2f100c4e4dffafaba636e0c98fb1b9f04f
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
