#!/usr/bin/env bash

#shellcheck disable=SC1091
test -f "/scripts/umask.sh" && source "/scripts/umask.sh"

/nordvpn-scripts/whitelist.sh

#shellcheck disable=SC2086
exec \
    /usr/sbin/nordvpnd
