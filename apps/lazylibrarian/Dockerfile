FROM ghcr.io/cdloh/alpine:3.20.3@sha256:e1fb78c6c398db9356454b832e3b03ab8b74976b8f0b30309ae709e6b8e1ea43

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1

#hadolint ignore=DL3018,DL3013
RUN apk add --no-cache \
        ca-certificates \
        python3 \
        py3-cffi \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        musl-dev \
        python3-dev \
        py3-pip \
        git \
    && git clone https://gitlab.com/LazyLibrarian/LazyLibrarian.git . \
    && if [ -n "${VERSION}" ]; then \
        NUMBER_COMMITS_TO_REVERT=$(( $(git rev-list --count --first-parent HEAD) - $(echo "${VERSION}" | cut -d "." -f3) )); \
        git checkout "master~${NUMBER_COMMITS_TO_REVERT}"; \
    fi \
    && LAZYLIB_COMMIT_VERSION=$(git rev-parse HEAD) \
    && echo "LAZYLIBRARIAN_VERSION = \"Package\"" > lazylibrarian/version.py \
    && echo "LAZYLIBRARIAN_HASH=\"$LAZYLIB_COMMIT_VERSION\"" >> lazylibrarian/version.py \
    && pip install --upgrade --no-cache-dir . \
    && pip install --upgrade --no-cache-dir python-Levenshtein \
    && apk del --purge .build-deps \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

USER kah
COPY ./apps/lazylibrarian/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://gitlab.com/LazyLibrarian/LazyLibrarian"
