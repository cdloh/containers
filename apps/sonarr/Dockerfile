FROM ghcr.io/cdloh/alpine:3.19.0@sha256:99cd9b1b7f9ef6e9f95c3f408caafa2f100c4e4dffafaba636e0c98fb1b9f04f

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    SONARR__INSTANCE_NAME="Sonarr" \
    SONARR__BRANCH="${CHANNEL}" \
    SONARR__PORT="8989" \
    SONARR__ANALYTICS_ENABLED="False"

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
    case "${CHANNEL}" in \
        'stable') export CURL_URL="https://download.sonarr.tv/v4/${SONARR__BRANCH}/${VERSION}/Sonarr.${SONARR__BRANCH}.${VERSION}.linux-musl-${ARCH}.tar.gz";; \
        'develop') export CURL_URL="https://github.com/Sonarr/Sonarr/releases/download/v${VERSION}/Sonarr.develop.${VERSION}.linux-musl-x64.tar.gz";; \
        ;; \
    esac \
    curl -fsSL $CURL_URL | tar xzf - -C /app/bin --strip-components=1 \
    && \
    rm -rf \
        /app/bin/Sonarr.Update \
    && \
    printf "UpdateMethod=docker\nBranch=%s\nPackageVersion=%s\nPackageAuthor=[cdloh](https://github.com/cdloh)\n" "${SONARR__BRANCH}" "${VERSION}" > /app/package_info \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

USER kah

COPY ./apps/sonarr/config.xml.tmpl /app/config.xml.tmpl
COPY ./apps/sonarr/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.title="${SONARR__INSTANCE_NAME} (${SONARR__BRANCH})"
