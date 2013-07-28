#!/usr/bin/env bash

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi

_installaur lxc-docker-git
# You will need to greate a new config for grub if
# you dont already have a aufs friendly kernel installed.
grub-mkconfig -o /boot/grub/grub.cfg
