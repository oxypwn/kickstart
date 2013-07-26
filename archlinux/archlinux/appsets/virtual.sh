#!/usr/bin/env bash

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi



# Install virtualization tools

# virtualbox
_installpkg virtualbox qt virtualbox-guest-iso
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/virtualbox.conf -o /etc/modules-load.d/virtualbox.conf

# kvm
_installpkg qemu qemu-launcher 
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/kvm.conf -o /etc/modules-load.d/kvm.conf

# vagrant
_installaur vagrant
