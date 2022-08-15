# NordVPN

A basic NordVPN container based off [bubuntux's container](https://github.com/bubuntux/nordvpn) to use as a sidecar container in Kubernetes for VPN Gateways.

Comes with automatic login, configuration & watching of the NordVPN connection. Examples using the [k8s-at-home Pod Gateway](https://docs.k8s-at-home.com/guides/pod-gateway/) are included.

<!-- MarkdownTOC -->

- [Watch & Healthcheck](#watch--healthcheck)
- [Authenticating](#authenticating)
- [Usage Examples](#usage-examples)
  - [Basic Example](#basic-example)
  - [`VPN_BLOCK_OTHER_TRAFFIC` enabled](#vpn_block_other_traffic-enabled)
  - [Login survival no VPN credentials](#login-survival-no-vpn-credentials)
- [ENVIRONMENT VARIABLES](#environment-variables)
  - [NordVPND Container](#nordvpnd-container)
  - [Client container](#client-container)

<!-- /MarkdownTOC -->

# Watch & Healthcheck

By default the `client.sh` container will (after login and configuring the VPN) watch the NordVPN connection and reconnect you to a different server when the load gets over 75%. This is configurable with the `CHECK_CONNECTION_INTERVAL` & `LOAD` environment variables.

There is a healthcheck at `/nordvpn-scripts/healthcheck` that can be used to confirm the VPN is secure. However the NordVPN `check/full` endpoint is not always accurate so it's likely best to write your own healthcheck.


# Authenticating

The container by default starts a `nordvpnd` process. Start a second container in the pod and put `/run/nordvpn` on a shared volume and run `/client.sh`. It will check to see if the the daemon is already logged in.

If the `WAIT_FOR_LOGIN` environment variable is set the client script will wait for the daemon to login. At this point you can shell into the container and login manually.

The client script supports `USER` / `USERFILE` & `PASS` / `PASSFILE` environment variables that will attempt to login.

If you want the login to survive pod restarts there is an example below that uses `WAIT_FOR_LOGIN` and a shared volume.

# Usage Examples

Below are some example usages with the k8s-at-home VPN hateway helm chart.

## Basic Example

The VPN credentials are in a Secret mounted to `/vpn-cred`. Login is done every boot.

```
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: vpn-gateway
  namespace: vpn
spec:
  interval: 5m
  chart:
    spec:
      # renovate: registryUrl=https://k8s-at-home.com/charts/
      chart: pod-gateway
      version: 5.6.2
      sourceRef:
        kind: HelmRepository
        name: k8s-at-home-charts
        namespace: flux-system
      interval: 5m

  values:
    persistence:
      vpn-creds:
        enabled: true
        type: secret
        name: vpn-login
      nordvpn:
        enabled: true
        type: emptyDir
        medium: Memory
    image:
      repository: ghcr.io/k8s-at-home/pod-gateway
      image: v1.6.1
    webhook:
      image:
        repository: ghcr.io/k8s-at-home/gateway-admision-controller
        tag: v3.5.0
    routed_namespaces:
      - vpned-apps
    settings:
      NOT_ROUTED_TO_GATEWAY_CIDRS: "10.42.0.0/16 10.43.0.0/16 192.168.0.0/24"
      VPN_INTERFACE: nordlynx
      VPN_LOCAL_CIDRS: "10.0.0.0/8 192.168.0.0/24"

    podDnsPolicy: "None"
    podDnsConfig:
      nameservers:
        # NordVPN DNS Servers
        - "103.86.96.100"
        - "103.86.99.100"

    additionalContainers:
      nordvpnd:
        name: nordvpnd
        image: ghcr.io/cdloh/nordvpn:3.14.2
        volumeMounts:
          - name: nordvpn
            mountPath: /run/nordvpn

        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"
      nordvpn:
        name: nordvpn
        image: ghcr.io/cdloh/nordvpn:3.14.2
        env:
          - name: USERFILE
            value: /vpn-creds/username
          - name: PASSFILE
            value: /vpn-creds/password
          - name: NET_LOCAL
            value: 192.168.0.0/24 10.42.0.0/16 10.43.0.0/16 172.16.0.0/24
		  command:
		    - /client.sh
        volumeMounts:
          - name: vpn-creds
            readOnly: true
            mountPath: /vpn-creds
          - name: nordvpn
            mountPath: /run/nordvpn
        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"

```

## `VPN_BLOCK_OTHER_TRAFFIC` enabled

Below is an example where `VPN_BLOCK_OTHER_TRAFFIC` is enabled.

NordVPND on boot calls back home to update it's server list and attempt to login. There is no defined list of domain names or config file to read from and the domains change each version of the NordVPN package.

To be able to use the daemon with `VPN_BLOCK_OTHER_TRAFFIC` the container must open the firewall before starting the daemon.

The NordVPND container will whietelist any IPs and Hostnames that are provided in the `NORDVPN_WHITELIST_IPS` & `NORDVPN_WHITELIST_HOSTS` environment variables.


```
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: vpn-gateway
  namespace: vpn
spec:
  interval: 5m
  chart:
    spec:
      # renovate: registryUrl=https://k8s-at-home.com/charts/
      chart: pod-gateway
      version: 5.6.2
      sourceRef:
        kind: HelmRepository
        name: k8s-at-home-charts
        namespace: flux-system
      interval: 5m

  values:
    persistence:
      vpn-creds:
        enabled: true
        type: secret
        name: vpn-login
      nordvpn:
        enabled: true
        type: emptyDir
        medium: Memory
    image:
      repository: ghcr.io/k8s-at-home/pod-gateway
      image: v1.6.1
    webhook:
      image:
        repository: ghcr.io/k8s-at-home/gateway-admision-controller
        tag: v3.5.0
    routed_namespaces:
      - vpned-apps
    settings:
      NOT_ROUTED_TO_GATEWAY_CIDRS: "10.42.0.0/16 10.43.0.0/16 192.168.0.0/24"
      VPN_INTERFACE: nordlynx
      VPN_BLOCK_OTHER_TRAFFIC: true
      VPN_LOCAL_CIDRS: "10.0.0.0/8 192.168.0.0/24"

    podDnsPolicy: "None"
    podDnsConfig:
      nameservers:
        # NordVPN DNS Servers
        - "103.86.96.100"
        - "103.86.99.100"

    additionalContainers:
      nordvpnd:
        name: nordvpnd
        image: ghcr.io/cdloh/nordvpn:3.14.2
        env:
            # NordVPN DNS servers
          - name: NORDVPN_WHITELIST_IPS
            value: "103.86.96.100 103.86.99.100"
            # All hosts required for NordVPN 3.14.2
          - name: NORDVPN_WHITELIST_HOSTS
            value: "cdn.zwyr157wwiu6eior.com downloads.se3v5tjfff3aet.me downloads.otmwumj6qw5em0zb.me downloads.njtzzrvg0lwj3bsn.info downloads.ltlxvxjjmvhn.me downloads.x9fnzrtl4x8pynsf.com downloads.nordcdn.com downloads.wutlk3t9mybdz.info downloads.icpsuawn1zy5amys.com downloads.mzhlhrfr8z.info downloads.73dkt-vwrqs.xyz downloads.ns8469rfvth42.xyz downloads.judua3rtinpst0s.xyz downloads.mxo4bkqvdityebzvp.xyz downloads.tptn0rhbtj.info downloads.p99nxpivfscyverz.me napps-1.com"
        volumeMounts:
          - name: nordvpn
            mountPath: /run/nordvpn

        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"
      nordvpn:
        name: nordvpn
        image: ghcr.io/cdloh/nordvpn:3.14.2
        env:
          - name: USERFILE
            value: /vpn-creds/username
          - name: PASSFILE
            value: /vpn-creds/password
          - name: NET_LOCAL
            value: 192.168.0.0/24 10.42.0.0/16 10.43.0.0/16 172.16.0.0/24
      command:
        - /client.sh
        volumeMounts:
          - name: vpn-creds
            readOnly: true
            mountPath: /vpn-creds
          - name: nordvpn
            mountPath: /run/nordvpn
        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"

```

## Login survival no VPN credentials

To survive logins two files are required, `settings.dat` & `install.dat`. Volume mounting those in the `client` & `daemon` containers will let the daemon automatically login on startup.


```
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: vpn-gateway
  namespace: vpn
spec:
  interval: 5m
  chart:
    spec:
      # renovate: registryUrl=https://k8s-at-home.com/charts/
      chart: pod-gateway
      version: 5.6.2
      sourceRef:
        kind: HelmRepository
        name: k8s-at-home-charts
        namespace: flux-system
      interval: 5m

  values:
    persistence:
      nordvpn:
        enabled: true
        type: emptyDir
        medium: Memory
      vpn-config:
        enabled: true
        existingClaim: vpn-config

    image:
      repository: ghcr.io/k8s-at-home/pod-gateway
      image: v1.6.1
    webhook:
      image:
        repository: ghcr.io/k8s-at-home/gateway-admision-controller
        tag: v3.5.0
    routed_namespaces:
      - vpned-apps
    settings:
      NOT_ROUTED_TO_GATEWAY_CIDRS: "10.42.0.0/16 10.43.0.0/16 192.168.0.0/24"
      VPN_INTERFACE: nordlynx
      VPN_BLOCK_OTHER_TRAFFIC: true
      VPN_LOCAL_CIDRS: "10.0.0.0/8 192.168.0.0/24"

    podDnsPolicy: "None"
    podDnsConfig:
      nameservers:
        # NordVPN DNS Servers
        - "103.86.96.100"
        - "103.86.99.100"

    additionalContainers:
      nordvpnd:
        name: nordvpnd
        image: ghcr.io/cdloh/nordvpn:3.14.2
        env:
            # NordVPN DNS servers
          - name: NORDVPN_WHITELIST_IPS
            value: "103.86.96.100 103.86.99.100"
            # All hosts required for NordVPN 3.14.2
          - name: NORDVPN_WHITELIST_HOSTS
            value: "cdn.zwyr157wwiu6eior.com downloads.se3v5tjfff3aet.me downloads.otmwumj6qw5em0zb.me downloads.njtzzrvg0lwj3bsn.info downloads.ltlxvxjjmvhn.me downloads.x9fnzrtl4x8pynsf.com downloads.nordcdn.com downloads.wutlk3t9mybdz.info downloads.icpsuawn1zy5amys.com downloads.mzhlhrfr8z.info downloads.73dkt-vwrqs.xyz downloads.ns8469rfvth42.xyz downloads.judua3rtinpst0s.xyz downloads.mxo4bkqvdityebzvp.xyz downloads.tptn0rhbtj.info downloads.p99nxpivfscyverz.me napps-1.com"
        volumeMounts:
          - name: nordvpn
            mountPath: /run/nordvpn
          - name: vpn-config
            mountPath: /var/lib/nordvpn/data/settings.dat
            subPath: settings.dat
          - name: vpn-config
            mountPath: /var/lib/nordvpn/data/install.dat
            subPath: install.dat

        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"
      nordvpn:
        name: nordvpn
        image: ghcr.io/cdloh/nordvpn:3.14.2
        env:
          - name: WAIT_FOR_LOGIN
            value: true
          - name: NET_LOCAL
            value: 192.168.0.0/24 10.42.0.0/16 10.43.0.0/16 172.16.0.0/24
      command:
        - /client.sh
        volumeMounts:
          - name: nordvpn
            mountPath: /run/nordvpn
          - name: vpn-config
            mountPath: /var/lib/nordvpn/data/settings.dat
            subPath: settings.dat
          - name: vpn-config
            mountPath: /var/lib/nordvpn/data/install.dat
            subPath: install.dat

        securityContext:
          privileged: true
          capabilities:
            add:
              - "NET_ADMIN"

```


# ENVIRONMENT VARIABLES

## NordVPND Container

* `NORDVPN_WHITELIST_IPS`   - List of space seperated IP Addresses that are whitelisted in the firewall before  starting NordVPND
* `NORDVPN_WHITELIST_HOSTS` - List of space seperated hostnames that will be whitelisted in the firewall before starting NordVPND
  - Ensure that DNS lookups work in the container as each hostname will be resolved to be added to iptables

## Client container

* `USER`     - User for NordVPN account.
* `PASS`     - Password for NordVPN account, surrounding the password in single quotes will prevent issues with special characters such as `$`.
* `PASSFILE` - File from which to get `PASS`. This file should contain just the account password on the first line.
* `USERFILE` - File from which to get `USER`. This file should contain just the account username on the first line.
* `WAIT_FOR_LOGIN` - Wait for NordVPN to be logged in rather then attempting legacy login
* `CONNECT`  -  [country]/[server]/[country_code]/[city]/[group] or [country] [city], if none provide you will connect to  the recommended server.
   - Provide a [country] argument to connect to a specific country. For example: Australia , Use `docker run --rm ghcr.io/bubuntux/nordvpn nordvpn countries` to get the list of countries.
   - Provide a [server] argument to connect to a specific server. For example: jp35 , [Full List](https://nordvpn.com/servers/tools/)
   - Provide a [country_code] argument to connect to a specific country. For example: us
   - Provide a [city] argument to connect to a specific city. For example: 'Hungary Budapest' , Use `docker run --rm ghcr.io/bubuntux/nordvpn nordvpn cities [country]` to get the list of cities.
   - Provide a [group] argument to connect to a specific servers group. For example: P2P , Use `docker run --rm ghcr.io/bubuntux/nordvpn nordvpn groups` to get the full list.
   - --group value  Specify a server group to connect to. For example: '--group p2p us'
* `PRE_CONNECT` - Command to execute before attempt to connect.
* `POST_CONNECT` - Command to execute after successful connection.
* `CYBER_SEC`  - Enable or Disable. When enabled, the CyberSec feature will automatically block suspicious websites so that no malware or other cyber threats can infect your device. Additionally, no flashy ads will come into your sight. More information on how it works: https://nordvpn.com/features/cybersec/.
* `DNS` -   Can set up to 3 DNS servers. For example 1.1.1.1,8.8.8.8 or Disable, Setting DNS disables CyberSec.
* `OBFUSCATE`  - Enable or Disable. When enabled, this feature allows to bypass network traffic sensors which aim to detect usage of the protocol and log, throttle or block it (only valid when using OpenVpn).
* `PROTOCOL`   - TCP or UDP (only valid when using OpenVPN).
* `TECHNOLOGY` - Specify Technology to use (NordLynx by default):
   * OpenVPN    - Traditional connection.
   * NordLynx   - NordVpn wireguard implementation (3x-5x times faster than OpenVPN).
* `ALLOW_LIST` - List of domains that are going to be accessible _outside_ vpn (IE rarbg.to,yts.mx).
* `NET_LOCAL`  - CIDR networks (IE 192.168.1.0/24), add a route to allows replies once the VPN is up.
* `NET6_LOCAL` - CIDR IPv6 networks (IE fe00:d34d:b33f::/64), add a route to allows replies once the VPN is up.
* `PORTS`  - Semicolon delimited list of ports to whitelist for both UDP and TCP. For example '- PORTS=9091;9095'
* `PORT_RANGE`  - Port range to whitelist for both UDP and TCP. For example '- PORT_RANGE=9091 9095'
* `CHECK_CONNECTION_INTERVAL`  - Time in seconds to check connection and reconnect if need it. (300 by default) For example '- CHECK_CONNECTION_INTERVAL=600'
* `CHECK_CONNECTION_URL`  - URL for checking Internet connection. (www.google.com by default) For example '- CHECK_CONNECTION_URL=www.custom.domain'
* `LOAD` - Load % to use when checking server load during watch client stage (default 75)
* `CHECK_CONNECTION_INTERVAL` - Interval to use when checking the server load
