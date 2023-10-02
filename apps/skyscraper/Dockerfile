FROM ghcr.io/cdloh/ubuntu:jammy-20221101@sha256:8668f8ac874067554d5ff130be352a781d712a79cec6db406191251092bdc11b as build
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



FROM ghcr.io/cdloh/ubuntu:jammy-20221101@sha256:8668f8ac874067554d5ff130be352a781d712a79cec6db406191251092bdc11b

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