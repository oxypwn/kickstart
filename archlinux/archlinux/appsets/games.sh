#!/usr/bin/env bash
# Games

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi


_installpkg warsow snes9x
_installpkg jre7-openjdk
_installaur minecraft
_installpkg steam
