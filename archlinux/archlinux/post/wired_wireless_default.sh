# ------------------------------------------------------------------------
# NETWORK
# ------------------------------------------------------------------------
#https://www.archlinux.org/news/netctl-is-now-in-core/

_installpkg coreutils
_installpkg dhcpcd
_installpkg iproute2
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

systemctl enable netctl-auto@wlan0.service 
systemctl enable netctl-ifplugd@eth0.service

cat > /etc/conf.d/netcfg << EOF
NETWORKS=(last)
WIRED_INTERFACE="eth0"
WIRELESS_INTERFACE="wlan0"
AUTO_PROFILES=("${NETWORK_PROFILE}")

EOF

cat > /etc/netctl/ethernet-static << EOF
CONNECTION='ethernet'
DESCRIPTION='A basic static ethernet connection using iproute'
INTERFACE='eth0'
IP='static'
ADDR='192.168.2.90'
#ROUTES=('192.168.1.0/24 via 192.168.2.1')
GATEWAY='192.168.2.1'
DNS=('192.168.2.1')

## For IPv6 autoconfiguration
#IP6=stateless

## For IPv6 static address configuration
#IP6='static'
#ADDR6=('1234:5678:9abc:def::1/64' '1234:3456::123/96')
#ROUTES6=('abcd::1234')
#GATEWAY6='1234:0:123::abcd'

EOF





mv /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.orig
echo -e "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=network\nupdate_config=1" > /etc/wpa_supplicant/wpa_supplicant.conf

cat > /usr/bin/wifi << EOF
#!/bin/bash
#
# wifi: helper script for wifi-menu
#
# You can set /usr/bin/wifi-menu to allow use without passwords in /etc/sudoers (via visudo)
# but wifi-menu still only checks if you are root or sudoing, unlike netcfg.
# This simply wraps wifi-menu in sudo.

sudo wifi-menu
EOF
chmod a+x /usr/bin/wifi
