#!/bin/bash

while true; do
  sleep "${CHECK_CONNECTION_INTERVAL:-300}"
  LOAD=75
  nordvpn_current_server=$(/usr/bin/nordvpn status | grep server | cut -b 17-)
  server_load=$(curl -s https://nordvpn.com/api/server/stats/$nordvpn_current_server | jq -r '.[]')

  #Check serverload value is not empty
  if [ -z "$server_load" ];then
    echo "($(date "+%Y-%m-%d %H:%M:%S")) ERROR: No response from NordVPN API to get server load. This check to restart OpenVPN will be ignored."
    continue
  fi

  #Check serverload with expected load
  if [ $server_load -gt $LOAD ]; then
    echo "($(date "+%Y-%m-%d %H:%M:%S")) WARNING: Load on $nordvpn_current_server is to high! Current load is $server_load and expected is $LOAD"
    echo "($(date "+%Y-%m-%d %H:%M:%S")) WARNING: OpenVPN will be restarted!"
    /usr/bin/nordvpn connect ${CONNECT}
  else
    echo "($(date "+%Y-%m-%d %H:%M:%S")) INFO: The current load of $server_load on $nordvpn_current_server is okay"
  fi

done

exit 0
