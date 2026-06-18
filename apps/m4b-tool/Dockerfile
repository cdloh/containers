FROM sandreas/ffmpeg:5.0.1-3 as ffmpeg
FROM sandreas/tone:v0.1.4 as tone
FROM sandreas/mp4v2:2.1.1 as mp4v2
FROM sandreas/fdkaac:2.0.1 as fdkaac

FROM ghcr.io/cdloh/alpine:3.19.1@sha256:eb1014101364aba400f9c0bf38cf916cd2760f198d29467891bafcc8d46dd497 as build

ARG VERSION
ENV WORKDIR /mnt/
ENV M4BTOOL_TMP_DIR /tmp/m4b-tool/


RUN echo "---- INSTALL RUNTIME PACKAGES ----" && \
  apk add --no-cache --update --upgrade \
  # mp4v2: required libraries
  libstdc++ \
  # m4b-tool: php cli, required extensions and php settings
  php83-cli \
  php83-dom \
  php83-json \
  php83-xml \
  php83-mbstring \
  php83-phar \
  php83-tokenizer \
  php83-xmlwriter \
  php83-openssl \
  composer \
  git \
  && echo "date.timezone = UTC" >> /etc/php83/php.ini \
  && ln -s /usr/bin/php83 /bin/php \
  && git clone https://github.com/sandreas/m4b-tool.git . \
  && if [ -n "${VERSION}" ]; then \
    NUMBER_COMMITS_TO_REVERT=$(( $(git rev-list --count --first-parent HEAD) - $(echo "${VERSION}" | cut -d "." -f3) )); \
    git checkout "master~${NUMBER_COMMITS_TO_REVERT}"; \
  fi \
  && composer install --no-dev --ignore-platform-reqs \
  && php -d phar.readonly=off tools/box.phar build \
  && chmod +x dist/*.phar && tar -C dist -czf dist/m4b-tool.tar.gz m4b-tool.phar


FROM ghcr.io/cdloh/alpine:3.19.1@sha256:eb1014101364aba400f9c0bf38cf916cd2760f198d29467891bafcc8d46dd497


RUN echo "---- INSTALL RUNTIME PACKAGES ----" && \
  apk add --no-cache --update --upgrade \
  # mp4v2: required libraries
  libstdc++ \
  # m4b-tool: php cli, required extensions and php settings
  php83-cli \
  php83-dom \
  php83-json \
  php83-xml \
  php83-mbstring \
  php83-phar \
  php83-tokenizer \
  php83-xmlwriter \
  php83-openssl \
  && echo "date.timezone = UTC" >> /etc/php83/php.ini \
  && ln -s /usr/bin/php83 /bin/php

COPY --from=ffmpeg /usr/local/bin/ffmpeg /usr/local/bin/
COPY --from=ffmpeg /usr/local/bin/ffprobe /usr/local/bin/
COPY --from=tone /usr/local/bin/tone /usr/local/bin/
COPY --from=mp4v2 /usr/local/bin/mp4* /usr/local/bin/
COPY --from=mp4v2 /usr/local/lib/libmp4v2* /usr/local/lib/
COPY --from=fdkaac /usr/local/bin/fdkaac /usr/local/bin/
COPY --from=build /app/dist/m4b-tool.phar /usr/local/bin/m4b-tool


WORKDIR ${WORKDIR}
ENTRYPOINT ["/usr/local/bin/m4b-tool"]
