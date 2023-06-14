FROM ghcr.io/cdloh/alpine:3.17.4@sha256:063ec4426b3cc4b49a516f4111c21621a31214eef9a3321118b8fdf3e8c8dc6b

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
