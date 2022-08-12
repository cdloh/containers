#!/usr/bin/env bash
version="$(curl https://repo.nordvpn.com/deb/nordvpn/debian/dists/stable/main/binary-amd64/Packages | grep -A 1 "Package: nordvpn$" | grep Version | sort | tail -n1)"
version="${version#*Version: }"
printf "%s" "${version}"
