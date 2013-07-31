#!/usr/bin/env bash

cat > /etc/netctl/enp2s0-static << EOF
Connection=enp2s0-static
Description='A basic static ethernet connection using iproute'
Interface=enp2s0
IP=static
Address=('${IPADDRESS}')
#Routes=('192.168.1.0/24 via 192.168.2.1')
Gateway='${GATEWAY}'
DNS=('${DNS}')

## For IPv6 autoconfiguration
#IP6=stateless

## For IPv6 static address configuration
#IP6=static
#Adress66=('1234:5678:9abc:def::1/64' '1234:3456::123/96')
#Routes6=('abcd::1234')
#Gateway6='1234:0:123::abcd'

EOF

systemctl enable netctl-ifplugd@enp2s0.service

