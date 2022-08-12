#!/bin/bash

if [[ ! -f /connected ]]
then
    echo "Looks like VPN isn't connected. Not going to healthcheck."
    exit 0;
fi

if [[ $( curl https://api.nordvpn.com/vpn/check/full | jq -r '.["status"]' ) = "Protected" ]] ; then exit 0; else exit 1; fi
