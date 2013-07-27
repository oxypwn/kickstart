#!/usr/bin/env bash
# Install virtualization tools

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi


# virtualbox
_installpkg virtualbox-guest-utils
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/virtualbox_guest.conf -o /etc/modules-load.d/virtualbox_guest.conf

