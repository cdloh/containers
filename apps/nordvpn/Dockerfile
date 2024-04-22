FROM ghcr.io/cdloh/ubuntu:jammy-20240405@sha256:c25bc3d769a17eef3780520278fe958a3fb5bec907012e94ae57487e290ad259
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
