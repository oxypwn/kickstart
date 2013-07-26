#!/usr/bin/env bash
# Games

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi


_installpkg warsow snes9x
_installpkg jre7-openjdk
_installaur minecraft
_installpkg steam
