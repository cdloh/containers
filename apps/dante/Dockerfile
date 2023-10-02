FROM ghcr.io/cdloh/alpine:3.18.4@sha256:7ef8932eac43c35619ad1d035ebeca47009496f823bf36d9b87ac50b612d36f4

ARG VERSION

RUN set -x \
    # Install dependencies.
 && apk add dante-server=${VERSION} --no-cache

# Basic config. No authentication
COPY ./apps/dante/sockd.conf /etc/sockd.conf

# Default port
EXPOSE 1080

CMD ["sockd"]
