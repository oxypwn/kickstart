#!/usr/bin/env bash
# Docker
# http://docs.docker.io/en/latest/installation/archlinux/

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 2>&1
    exit 1
fi

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi

# Install dependencies
_installpkg xmlto docbook-xsl bc

# We need to set TMPDIR other than /tmp as building the kernel might fill up the disk.
if [ ! -d /root/TMPDIR ]; then
    mkdir /root/TMPDIR && export TMPDIR=/root/TMPDIR
fi

# Install docker from aur
_installaur lxc-docker

# You will need to greate a new config for grub if
# you dont already have a aufs friendly kernel installed.
grub-mkconfig -o /boot/grub/grub.cfg

systemctl start docker
systemctl enable docker

sysctl net.ipv4.ip_forward=1
# Make above setting permanent.
curl -fsL ${REMOTE}/archlinux/conf/sysctl.conf -o /etc/sysctl.conf

