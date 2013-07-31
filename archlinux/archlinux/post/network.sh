#!/usr/bin/env bash
# NETWORK

_installpkg bridge-utils # (optional) - for bridge connections
_installpkg dialog # (optional) - for the menu based profile and wifi selectors
_installpkg ifenslave # (optional) - for bond connections
_installpkg wireless_tools # (optional) - for interface renaming through net-rename
_installpkg wpa_supplicant # (optional) - for wireless networking support
_installpkg iw rfkill

# Automatic switching of profiles
# https://wiki.archlinux.org/index.php/Netctl#Automatic_switching_of_profiles
_installpkg ifplugd
_installpkg wpa_actiond


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
