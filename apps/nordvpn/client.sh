#!/bin/bash

test -f "/scripts/umask.sh" && source "/scripts/umask.sh"

sleep 30

/nordvpn-scripts/login.sh
/nordvpn-scripts/config.sh
/nordvpn-scripts/connect.sh
/nordvpn-scripts/watch.sh
