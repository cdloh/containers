#!/bin/bash

i=0
while [ $i -le 31 ]
do

  if [[ -S /run/nordvpn/nordvpnd.sock ]]
  then
    echo "VPN started!"
    break
  fi
  sleep 10
done


if /usr/bin/nordvpn account > /dev/null; then
    echo "NordVPN logged in moving on"
    exit 0
fi

[[ -z "${PASS}" ]] && [[ -f "${PASSFILE}" ]] && PASS="$(head -n 1 "${PASSFILE}")"
[[ -z "${USER}" ]] && [[ -f "${USERFILE}" ]] && USER="$(head -n 1 "${USERFILE}")"


/usr/bin/nordvpn login --legacy --username "${USER}" --password "${PASS}" || {
  echo "Invalid Username or password."
  exit 1
}

exit 0
