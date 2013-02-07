#!/bin/bash

# Install virtualization tools

# virtualbox
_installpkg virtualbox-guest-utils
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/virtualbox_guest.conf -o /etc/modules-load.d/virtualbox_guest.conf

