FROM ghcr.io/cdloh/ubuntu:jammy-20231004@sha256:16aa21c5ef48401279b56ccbe440553a8ccfe563e92c8afdac51539d96c12165 as build
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



FROM ghcr.io/cdloh/ubuntu:jammy-20231004@sha256:16aa21c5ef48401279b56ccbe440553a8ccfe563e92c8afdac51539d96c12165

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
