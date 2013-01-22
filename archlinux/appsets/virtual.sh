#!/bin/bash

# Install virtualbox, kvm

_installpkg virtualbox qt virtualbox-guest-iso qemu-kvm
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/virtualbox.conf -o /etc/modules-load.d/virtualbox.conf
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/kvm.conf -o /etc/modules-load.d/kvm.conf
