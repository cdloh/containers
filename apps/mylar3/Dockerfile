FROM ghcr.io/cdloh/alpine:rolling@sha256:7e2925a386dceec8bf8c7ed024392a212538576820ffbd9fa74a2f8abbfdb82a

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    CRYPTOGRAPHY_DONT_BUILD_RUST=1

ENV MYLAR3__PORT=8090

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    curl -fsSL "https://github.com/mylar3/mylar3/archive/refs/tags/v${VERSION}.tar.gz" \
        | tar xzf - -C /app --strip-components=1 \
    && \
    chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

#hadolint ignore=DL3018,DL3013
RUN \
    # Keep py3-pip installed
    \
    apk add --no-cache \
        ca-certificates \
        python3 \
        py3-pip \ 
        # runtime tools
        jpeg \
        libwebp-tools \
        nodejs \
        zlib \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        cargo \
        jpeg-dev \
        libffi-dev \
        libwebp-dev \
        musl-dev \
        openssl-dev \
        py3-cffi \
        python3-dev \
        zlib-dev \
    && \
    pip install --upgrade pip \
    && \
    pip install --upgrade --requirement /app/requirements.txt \
    && apk del --purge .build-deps \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

USER kah
COPY ./apps/mylar3/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/mylar3/mylar3"