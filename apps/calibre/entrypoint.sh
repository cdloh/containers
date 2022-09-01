#!/usr/bin/env bash

#shellcheck disable=SC1091
test -f "/scripts/umask.sh" && source "/scripts/umask.sh"

if [[ "${CALIBRE__CREATE_LIBRARY}" == "true" && ! -f "${CALIBRE__LIBRARY}/metadata.db" ]]; then
    # Populate a blank library
    /app/calibredb --library-path="${CALIBRE__LIBRARY}" list
fi

#shellcheck disable=SC2086
exec \
    /app/calibre-server \
        --port=${CALIBRE__PORT} \
        ${CALIBRE__LIBRARY} \
        "$@"
