ARG VERSION
ARG CHANNEL
ARG TARGETPLATFORM
FROM public.ecr.aws/docker/library/ubuntu:${VERSION}
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

# DEBIAN_FRONTEND: https://askubuntu.com/questions/972516/debian-frontend-environment-variable
# APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE: http://stackoverflow.com/questions/48162574/ddg#49462622
ENV \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    DEBIAN_FRONTEND="noninteractive" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
    UMASK="0002" \
    TZ="Etc/UTC"

# hadolint ignore=DL3002
USER root

RUN \
    adduser kah \
        --uid 568 \
        --group \
        --system \
        --disabled-password \
        --no-create-home \
    && \
    mkdir -p /config \
    && chown -R kah:kah /config \
    && chmod -R 775 /config

WORKDIR /app

# hadolint ignore=DL3008,DL3015
RUN \
    set -eux \
    && echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Get::Install-Recommends "false";' >>/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Get::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
    && \
    apt-get -qq update \
    && \
    apt-get install -y \
        bash \
        ca-certificates \
        coreutils \
        curl \
        dnsutils \
        iputils-ping \
        jo \
        jq \
        locales \
        moreutils \
        pv \
        tini \
        tzdata \
        rsync \
        vim-tiny \
        unrar \
        unzip \
        wget \
    && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && ln -s /usr/bin/vim.tiny /usr/local/bin/vi \
    && ln -s /usr/bin/vim.tiny /usr/local/bin/vim \
    && ln -s /usr/bin/vim.tiny /usr/local/bin/nano \
    && ln -s /usr/bin/vim.tiny /usr/local/bin/emacs \
    && chown -R kah:kah /app \
    && \
    printf "/bin/bash /scripts/greeting.sh\n" >> /etc/bash.bashrc \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/cache/apt/* \
        /var/tmp/*

ENV LANG en_US.UTF-8

VOLUME ["/config"]
COPY ./apps/ubuntu/scripts /scripts

ENTRYPOINT [ "/usr/bin/tini", "--" ]
