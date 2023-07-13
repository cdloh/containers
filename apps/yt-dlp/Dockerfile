FROM ghcr.io/cdloh/alpine:3.18.2@sha256:bc77ba9976d0b784daea3f2fb60eca5c6c984896958ddceecb337d2bd2e28e5e

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
