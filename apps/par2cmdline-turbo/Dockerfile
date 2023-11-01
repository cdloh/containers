FROM ghcr.io/cdloh/alpine:3.18.4@sha256:7aaedc72028b5310e79cbd47175e52395fa78c6d6ee2b250dd83a5805d00fe97 as build
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

FROM ghcr.io/cdloh/alpine:3.18.4@sha256:7aaedc72028b5310e79cbd47175e52395fa78c6d6ee2b250dd83a5805d00fe97
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
