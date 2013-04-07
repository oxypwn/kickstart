#!/bin/bash
#systemctl enable dhcpcd.service
ln -s '/usr/lib/systemd/dhcpcd.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd.service'
