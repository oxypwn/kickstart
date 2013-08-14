#!/usr/bin/env bash

# Device names
# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
INTUM=0
for address in /sys/class/net/e*/address ; do
    MAC=(`cat $address`)
    echo SUBSYSTEM=='"'net'"', ACTION=='"'add'"', ATTR{address}=='"'${MAC}'"', NAME='"'net${INTNUM}'"' >> /etc/udev/rules.d/10-network.rules
    INTUM=$(( $INTNUM + 1 ))
done

cat > /etc/netctl/net0-dhcp << EOF
Description='A basic dhcp ethernet connection'
Interface=net0
Connection=ethernet
IP=dhcp
## for DHCPv6
#IP6=dhcp
## for IPv6 autoconfiguration
#IP6=stateless

EOF

# Automatic switching of profiles
# https://wiki.archlinux.org/index.php/Netctl#Automatic_switching_of_profiles
systemctl enable netctl-ifplugd@net0.service


