FROM ghcr.io/cdloh/alpine:3.17.1@sha256:9e9b5c2416682a4305d7fdbf5914f0e1834df969e8f62401163bffeec3f49339

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
