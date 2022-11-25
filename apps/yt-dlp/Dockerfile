FROM ghcr.io/cdloh/alpine:3.17.0@sha256:7d4b2a50b637a844c0c8c1b7c3b4399a1450822bf0eae081ef45549410c60201

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
