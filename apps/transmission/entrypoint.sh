#!/usr/bin/env bash

#shellcheck disable=SC1091
test -f "/scripts/umask.sh" && source "/scripts/umask.sh"
test -f "/scripts/vpn.sh" && source "/scripts/vpn.sh"

#shellcheck disable=SC2086
exec \
    /app/transmission-daemon \
        --foreground \
        --config-dir /config \
        --port "${TRANSMISSION__RPC_PORT:-9091}" \
        "$@"
