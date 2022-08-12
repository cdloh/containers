FROM ghcr.io/cdloh/ubuntu:rolling@sha256:2c6a1fa6eb6cb23a65bc2644c01d55f64660bfee5f1734f135538ed672305279

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    SONARR__INSTANCE_NAME="Sonarr" \
    SONARR__BRANCH="${CHANNEL}" \
    SONARR__PORT="8989" \
    SONARR__ANALYTICS_ENABLED="False"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apt-get -qq update \
    && apt-get -qq install -y gnupg \
    && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official.list \
    && apt-get -qq update \
    && \
    apt-get -qq install -y \
        ca-certificates \
        mono-complete \
        ca-certificates-mono \
        libmediainfo0v5 \
        xmlstarlet \
    && \
    curl -fsSL "https://download.sonarr.tv/v3/${SONARR__BRANCH}/${VERSION}/Sonarr.${SONARR__BRANCH}.${VERSION}.linux.tar.gz" \
        | tar xzf - -C /app --strip-components=1 \
    && \
    printf "UpdateMethod=docker\nBranch=%s\nPackageVersion=%s\nPackageAuthor=[Team k8s-at-home](https://github.com/k8s-at-home)" "${SONARR__BRANCH}" "${VERSION}" > /app/package_info \
    && \
    gpgconf --kill all \
    && apt-get remove -y gnupg \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /app/Sonarr.Update \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/ \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

USER kah

COPY ./apps/sonarr/config.xml.tmpl /app/config.xml.tmpl
COPY ./apps/sonarr/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/Sonarr/Sonarr"