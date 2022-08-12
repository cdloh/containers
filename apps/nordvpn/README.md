# NordVPN

A basic NordVPN container based off [bubuntux's container](https://github.com/bubuntux/nordvpn) to use as a sidecar container in Kubernetes for VPN Gateways.

The container by default starts a `nordvpnd` process. Start a second container in the pod and put `/run/nordvpn` on a shared volume and run `/client.sh`. It will login and configure the VPN as per the ENVIRONMENT variables.

# Examples

Below is an example usage with the k8s-at-home VPN hateway helm chart. The VPN credentials are in a Secret mounted to `/vpn-cred`

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
      VPN_LOCAL_CIDRS: "10.0.0.0/8 192.168.0.0/16"

    podDnsPolicy: "None"
    podDnsConfig:
      nameservers:
        # NordVPN DNS Servers
        - "103.86.96.100"
        - "103.86.99.100"

    additionalContainers:
      nordvpnd:
        name: nordvpnd
        image: ghcr.io/cdloh/nordvpn:VERSION
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
        image: ghcr.io/cdloh/nordvpn:VERSION
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


# ENVIRONMENT VARIABLES

* `USER`     - User for NordVPN account.
* `PASS`     - Password for NordVPN account, surrounding the password in single quotes will prevent issues with special characters such as `$`.
* `PASSFILE` - File from which to get `PASS`. This file should contain just the account password on the first line.
* `USERFILE` - File from which to get `USER`. This file should contain just the account username on the first line.
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
* `FIREWALL`  - Enable or Disable.
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
