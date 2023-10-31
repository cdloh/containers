FROM ghcr.io/cdloh/alpine:3.18.4@sha256:7aaedc72028b5310e79cbd47175e52395fa78c6d6ee2b250dd83a5805d00fe97

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
