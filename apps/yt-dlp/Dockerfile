FROM ghcr.io/cdloh/alpine:3.20.0@sha256:28e5b08b2b5565061e7ac71ec8a5a04a57257e42c49eee1a6ffa7115c385a281

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
