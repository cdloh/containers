#!/bin/bash

# Whitelist a bunch of NordVPN IPs that we need to do initial logins etc
for nord_ip in $NORDVPN_WHITELIST_IPS; do
    # command might fail if rule already set
    echo "Whitelisting $nord_ip"

    iptables -A OUTPUT -p tcp -d $nord_ip -j ACCEPT
    iptables -A OUTPUT -p udp -d $nord_ip -j ACCEPT
done


# Whitelist a bunch of NordVPN IPs that we need to do initial logins etc
for nord_host in $NORDVPN_WHITELIST_HOSTS; do
    echo "Whitelisting $nord_host"


    ips=$(dig +short $nord_host)
    for ip in $ips; do
        echo "Whitelisting $ip"
        iptables -A OUTPUT -p tcp -d $ip -j ACCEPT
        iptables -A OUTPUT -p udp -d $ip -j ACCEPT
    done
done
