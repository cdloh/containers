#!/bin/bash

[[ -n ${DNS} ]] && /usr/bin/nordvpn set dns ${DNS//[;,]/ }

[[ -n ${CYBER_SEC} ]] && /usr/bin/nordvpn set cybersec ${CYBER_SEC}
[[ -n ${OBFUSCATE} ]] && /usr/bin/nordvpn set obfuscate ${OBFUSCATE}
[[ -n ${FIREWALL} ]] && /usr/bin/nordvpn set firewall ${FIREWALL}


[[ -n ${PROTOCOL} ]] && /usr/bin/nordvpn set protocol ${PROTOCOL}
/usr/bin/nordvpn set technology ${TECHNOLOGY:-NordLynx}

[[ -n ${PORTS} ]] && for port in ${PORTS//[;,]/ }; do /usr/bin/nordvpn whitelist add port "${port}"; done
[[ -n ${PORT_RANGE} ]] && /usr/bin/nordvpn whitelist add ports ${PORT_RANGE}

[[ -n ${NET_LOCAL} ]] && for net in ${NET_LOCAL}; do /usr/bin/nordvpn whitelist add subnet "${net}"; done

exit 0
