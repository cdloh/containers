FROM ghcr.io/cdloh/ubuntu:jammy-20240111@sha256:5fc52e6f13373e989a0e649f7a54d5893453d498d4395ba43b0ee121887a5611
LABEL maintainer="Callum Loh"

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update -y && \
    apt-get install -y curl iputils-ping libc6 wireguard jq && \
    curl https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb --output /tmp/nordrepo.deb && \
    apt-get install -y /tmp/nordrepo.deb && \
    apt-get update -y && \
    apt-get install -y nordvpn${VERSION:+=$VERSION} && \
    apt-get remove -y nordvpn-release && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    mkdir -p /run/nordvpn && \
    mkdir -p /nordvpn-scripts && \
    rm -rf \
        /tmp/* \
        /var/cache/apt/archives/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

COPY ./apps/nordvpn/client.sh /client.sh
COPY ./apps/nordvpn/scripts /nordvpn-scripts
COPY ./apps/nordvpn/healthcheck.sh /healthcheck.sh
COPY ./apps/nordvpn/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/cdloh/containers/blob/main/apps/nordvpn/README.md"
