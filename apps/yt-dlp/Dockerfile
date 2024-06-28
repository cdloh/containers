FROM ghcr.io/cdloh/alpine:3.20.1@sha256:cc69eca0ef2d4ad14fb75e20d33ce92b1901a9b00979a77d393e892d244d706d

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
