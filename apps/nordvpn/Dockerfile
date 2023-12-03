FROM ghcr.io/cdloh/ubuntu:jammy-20231128@sha256:4091c6cb4e272f4d28a158b94b16265a1fb0adb183dbe3ae9868a45e73c8f2e6
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
