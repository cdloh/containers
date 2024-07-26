FROM ghcr.io/cdloh/par2cmdline-turbo:1.1.1 as par2cmdline-turbo

FROM ghcr.io/cdloh/alpine:3.20.2@sha256:07dc32191d1e9ff5274df1bb33a662afed92147d30c1eb0bcbeea11641026e06
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    CRYPTOGRAPHY_DONT_BUILD_RUST=1

ENV SABNZBD__PORT=8080

# Download source
RUN \
    curl -fsSL "https://github.com/sabnzbd/sabnzbd/releases/download/${VERSION}/SABnzbd-${VERSION}-src.tar.gz" \
        | tar xzf - -C /app --strip-components=1 \
    && \
    chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

# Install sabnzbd
RUN \
    # Keep py3-pip installed
    \
    apk add --no-cache \
        ca-certificates \
        python3 \
        py3-pip \
        p7zip \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        libffi-dev \
        openssl-dev \
        musl-dev \
        cargo \
        python3-dev \
    && \
    pip install --upgrade pip \
    && \
    pip install --upgrade --requirement /app/requirements.txt \
    && apk del --purge .build-deps \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

# Install par2cmdline-turbo
COPY --from=par2cmdline-turbo /usr/local/bin/par2 /usr/local/bin/par2
RUN ln -s /usr/local/bin/par2 /usr/local/bin/par2create \
    && ln -s /usr/local/bin/par2 /usr/local/bin/par2repair \
    && ln -s /usr/local/bin/par2 /usr/local/bin/par2verify

USER kah
COPY ./apps/sabnzbd/sabnzbd.ini /app/sabnzbd.ini
COPY ./apps/sabnzbd/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/sabnzbd/sabnzbd"
