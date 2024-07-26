FROM ghcr.io/cdloh/alpine:3.20.2@sha256:07dc32191d1e9ff5274df1bb33a662afed92147d30c1eb0bcbeea11641026e06

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
