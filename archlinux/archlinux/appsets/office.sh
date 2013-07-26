#!/usr/bin/env bash
# Office

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi

_installpkg libreoffice-en-US libreoffice 
