FROM ghcr.io/cdloh/ubuntu:jammy-20231128@sha256:4091c6cb4e272f4d28a158b94b16265a1fb0adb183dbe3ae9868a45e73c8f2e6 as build
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN \
    apt-get -qq update \
    && \
    apt-get -qq install -y build-essential qtbase5-dev qt5-qmake qtbase5-dev-tools wget && \
    mkdir skyscraper && \
    cd skyscraper && \
    wget -N https://github.com/${CHANNEL}/skyscraper/archive/${VERSION}.tar.gz && \
    tar xvzf ${VERSION}.tar.gz --strip-components 1 --overwrite && \
    rm ${VERSION}.tar.gz && \
    qmake && \
    make -j$(nproc) && \
    make install



FROM ghcr.io/cdloh/ubuntu:jammy-20231128@sha256:4091c6cb4e272f4d28a158b94b16265a1fb0adb183dbe3ae9868a45e73c8f2e6

RUN \
    apt-get -qq update && \
    apt-get -qq install -y libqt5gui5 libqt5xml5 && \
    mkdir /app/.skyscraper && \
    usermod -d /app kah

# copy from builder
COPY --from=build /usr/local/bin/Skyscraper /usr/local/bin/Skyscraper
COPY --from=build /usr/local/etc/skyscraper /usr/local/etc/skyscraper


USER kah
COPY ./apps/skyscraper/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/${CHANNEL}/skyscraper"
