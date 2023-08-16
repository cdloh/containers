FROM ghcr.io/cdloh/alpine:3.18.3@sha256:8416f7ff758e0f0ab4e66f085b9d4dcb3dc75bf3ed1e7243156cd83456dfcbd1 as build
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

FROM ghcr.io/cdloh/alpine:3.18.3@sha256:8416f7ff758e0f0ab4e66f085b9d4dcb3dc75bf3ed1e7243156cd83456dfcbd1
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
