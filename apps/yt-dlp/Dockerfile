FROM ghcr.io/cdloh/alpine:rolling@sha256:ff764e599f4cd1c8e547a1ae33844df40509bcc0d4bd8522b0c05f0508bb5c7f

ARG VERSION

RUN set -x \
    # Install yt-dlp
 && apk add --no-cache python3 ffmpeg \
 && wget "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" -O /usr/local/bin/yt-dlp \
 && chmod +x /usr/local/bin/yt-dlp

USER kah

CMD ['/usr/local/bin/yt-dlp']
