FROM ghcr.io/cdloh/alpine:rolling@sha256:1eadc37a841913fe56e08b0e1bbaa8b087cb27d9a9eca2f9b553224b3b752c75

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
