#!/usr/bin/env bash

#shellcheck disable=SC1091
test -f "/scripts/umask.sh" && source "/scripts/umask.sh"
test -f "/scripts/vpn.sh" && source "/scripts/vpn.sh"


#shellcheck disable=SC2086
exec \
    /usr/bin/python3 \
        /app/Mylar.py \
        --nolaunch \
        --port :${MYLAR3__PORT:-8090} \
        --datadir /config \
        "$@"
