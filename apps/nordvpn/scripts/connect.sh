#!/bin/bash

[[ -n ${PRE_CONNECT} ]] && eval ${PRE_CONNECT}

echo "Connecting..."
current_sleep=1
until /usr/bin/nordvpn connect ${CONNECT}; do
  if [ ${current_sleep} -gt 4096 ]; then
    echo "Unable to connect."
    exit 1
  fi
  echo "Unable to connect retrying in ${current_sleep} seconds."
  sleep ${current_sleep}
  current_sleep=$((current_sleep * 2))
done

touch /connected

[[ -n ${POST_CONNECT} ]] && eval ${POST_CONNECT}

exit 0
