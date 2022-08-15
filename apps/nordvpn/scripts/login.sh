#!/bin/bash

i=0
while [ $i -le 31 ]
do

  if [[ -S /run/nordvpn/nordvpnd.sock ]]
  then
    echo "VPN started!"
    break
  fi
  echo "Waiting for NordVPNd..."
  sleep 10
  ((i++))
done

while :
do

  if /usr/bin/nordvpn account > /dev/null; then
    echo "NordVPN logged in moving on"
    exit 0
  fi

  # If we're going to try for legacy login play on
  if [[ -z "${WAIT_FOR_LOGIN}" ]]; then
    break
  fi
  echo "Waiting for login..."
  sleep 10
done


[[ -z "${PASS}" ]] && [[ -f "${PASSFILE}" ]] && PASS="$(head -n 1 "${PASSFILE}")"
[[ -z "${USER}" ]] && [[ -f "${USERFILE}" ]] && USER="$(head -n 1 "${USERFILE}")"


/usr/bin/nordvpn login --legacy --username "${USER}" --password "${PASS}" || {
  echo "Invalid Username or password."
  exit 1
}

exit 0
