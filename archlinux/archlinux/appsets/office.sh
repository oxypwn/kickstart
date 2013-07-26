#!/usr/bin/env bash
# Office

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi



_installpkg libreoffice-en-US libreoffice 
