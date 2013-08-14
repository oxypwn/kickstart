#!/usr/bin/env bash

# Device names
# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
INTNUM=0
for address in  /sys/class/net/e*/address ; do
    MAC=(`cat $address`)
    echo SUBSYSTEM=='"'net'"', ACTION=='"'add'"', ATTR{address}=='"'${MAC}'"', NAME='"'net${INTNUM}'"' >> /etc/udev/rules.d/10-network.rules
    INTNUM=$(( $INTNUM + 1 ))
done

cat > /etc/netctl/ethernet-static << EOF
Connection=ethernet
Description='A basic static ethernet connection using iproute'
Interface=net0
IP=static
Address=('${IPADDRESS}')
#Routes=('192.168.1.0/24 via 192.168.2.1')
Gateway='${GATEWAY}'
DNS=(${DNS})

## For IPv6 autoconfiguration
#IP6=stateless

## For IPv6 static address configuration
#IP6=static
#Adress66=('1234:5678:9abc:def::1/64' '1234:3456::123/96')
#Routes6=('abcd::1234')
#Gateway6='1234:0:123::abcd'

EOF

#netctl enable ethernet-static

# Automatic switching of profiles
# https://wiki.archlinux.org/index.php/Netctl#Automatic_switching_of_profiles
systemctl enable netctl-ifplugd@net0.service

