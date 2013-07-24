#!/usr/bin/env bash
# ------------------------------------------------------------------------
# NETWORK
# ------------------------------------------------------------------------
#https://www.archlinux.org/news/netctl-is-now-in-core/

_installpkg bridge-utils # (optional) - for bridge connections
_installpkg dialog # (optional) - for the menu based profile and wifi selectors
_installpkg ifenslave # (optional) - for bond connections
_installpkg ifplugd 
_installpkg wireless_tools # (optional) - for interface renaming through net-rename
_installpkg wpa_actiond 
_installpkg wpa_supplicant # (optional) - for wireless networking support
_installpkg iw rfkill

#systemctl enable net-auto-wired.service      # deprecated
#systemctl enable net-auto-wireless.service   # deprecated


MACADDRESS=$(cat /sys/class/net/eth0/address)


cat > /etc/udev/rules.d/10-network.rules << EOF
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="${MACADDRESS}", NAME="eth0"

EOF


cat > /etc/netctl/ethernet << EOF
Connection=ethernet
Description='A basic static ethernet connection using iproute'
Interface=eth0
IP=static
Address=('${IPADDRESS}')
#Routes=('192.168.1.0/24 via 192.168.2.1')
Gateway='192.168.2.1'
DNS=('192.168.2.1')

## For IPv6 autoconfiguration
#IP6=stateless

## For IPv6 static address configuration
#IP6=static
#Adress66=('1234:5678:9abc:def::1/64' '1234:3456::123/96')
#Routes6=('abcd::1234')
#Gateway6='1234:0:123::abcd'

EOF

#systemctl enable netctl-auto@wlan0.service
systemctl enable netctl-ifplugd@eth0.service



mv /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.orig
echo -e "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=network\nupdate_config=1" > /etc/wpa_supplicant/wpa_supplicant.conf

cat > /usr/bin/wifi << EOF
#!/usr/bin/bash
#
# wifi: helper script for wifi-menu
#
# You can set /usr/bin/wifi-menu to allow use without passwords in /etc/sudoers (via visudo)
# but wifi-menu still only checks if you are root or sudoing, unlike netcfg.
# This simply wraps wifi-menu in sudo.

sudo wifi-menu
EOF
chmod a+x /usr/bin/wifi
