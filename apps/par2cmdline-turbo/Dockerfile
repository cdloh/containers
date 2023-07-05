FROM ghcr.io/cdloh/alpine:3.18.2@sha256:bc77ba9976d0b784daea3f2fb60eca5c6c984896958ddceecb337d2bd2e28e5e as build
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

FROM ghcr.io/cdloh/alpine:3.18.2@sha256:bc77ba9976d0b784daea3f2fb60eca5c6c984896958ddceecb337d2bd2e28e5e
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
