FROM ghcr.io/cdloh/alpine:3.20.2@sha256:07dc32191d1e9ff5274df1bb33a662afed92147d30c1eb0bcbeea11641026e06

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    READARR__INSTANCE_NAME="Readarr" \
    READARR__BRANCH="${CHANNEL}" \
    READARR__PORT="8787" \
    READARR__ANALYTICS_ENABLED="False"

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates icu-libs libintl sqlite-libs xmlstarlet
#hadolint ignore=DL3059
RUN \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='x64' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && \
    mkdir -p /app/bin \
    && \
    curl -fsSL "https://readarr.servarr.com/v1/update/${READARR__BRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=${ARCH}" \
        | tar xzf - -C /app/bin --strip-components=1 \
    && \
    rm -rf \
        /app/bin/Readarr.Update \
    && \
    printf "UpdateMethod=docker\nBranch=%s\nPackageVersion=%s\nPackageAuthor=[onedr0p](https://github.com/onedr0p)\n" "${READARR__BRANCH}" "${VERSION}" > /app/package_info \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

USER kah

COPY ./apps/readarr/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/Readarr/Readarr"
