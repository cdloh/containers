FROM ghcr.io/cdloh/alpine:3.20.9@sha256:ce4c95822b5b212101aea53e94985a6b8802b540cac5b48296b015f800a5c233

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
