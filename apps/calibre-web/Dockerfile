FROM ghcr.io/cdloh/calibre-bare:9.2.0 as calibre

FROM ghcr.io/cdloh/ubuntu:jammy-20260109@sha256:0eb855195b0e1ae6cc6062849ec8cb7834384b8eff3d615e7b53750fa6b92979

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

ENV \
    CALIBRE_DBPATH=/config

ARG VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apt-get update \
    && \
    apt-get install -y \
        imagemagick \
        libegl1 \
        libfontconfig1 \
        libgl1-mesa-glx \
        libldap-2.5-0 \
        libnss3 \
        libopengl0 \
        libsasl2-2 \
        libxcomposite1 \
        libxdamage1 \
        libxi6 \
        libxkbcommon0 \
        libxrandr2 \
        libxslt1.1 \
        python3 \
        python3-pip \
        python3-pkg-resources \
    && \
    # Dev
    apt-get install -y \
        libldap2-dev \
        libsasl2-dev \
        python3-dev \
        gcc \
        g++ \
    && \
    curl -fsSL https://github.com/janeczku/calibre-web/archive/refs/tags/${VERSION}.tar.gz \
        | tar xzf - -C /app --strip-components=1 \
    && pip install --upgrade pip \
    && pip install --upgrade --requirement /app/requirements.txt \
    && pip install --upgrade --requirement /app/optional-requirements.txt \
    && apt-get purge -y --auto-remove libldap2-dev libsasl2-dev python3-dev gcc g++\
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/ \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

COPY --from=calibre / /opt/calibre

USER kah
COPY ./apps/calibre-web/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/janeczku/calibre-web"
