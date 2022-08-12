#!/bin/bash

test -f "/scripts/umask.sh" && source "/scripts/umask.sh"

sleep 30

/scripts/login.sh
/scripts/config.sh
/scripts/connect.sh
/scripts/watch.sh
