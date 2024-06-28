FROM ghcr.io/cdloh/alpine:3.20.1@sha256:cc69eca0ef2d4ad14fb75e20d33ce92b1901a9b00979a77d393e892d244d706d as build
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

FROM ghcr.io/cdloh/alpine:3.20.1@sha256:cc69eca0ef2d4ad14fb75e20d33ce92b1901a9b00979a77d393e892d244d706d
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
