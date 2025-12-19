FROM ghcr.io/cdloh/alpine:3.20.8@sha256:866800239e9d5fbd7bb7bcb0c1a54b2ab56b9db6c97cc020d6cb1a46fb44f4b4 as build
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

FROM ghcr.io/cdloh/alpine:3.20.8@sha256:866800239e9d5fbd7bb7bcb0c1a54b2ab56b9db6c97cc020d6cb1a46fb44f4b4
COPY --from=build /usr/local/bin/par2 /usr/local/bin/par2
RUN /usr/local/bin/par2 --help
CMD ["/usr/local/bin/par2"]
