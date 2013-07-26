#!/usr/bin/env bash
# Reader

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi

_installpkg newsbeuter zathura cups zathura-pdf-mupdf unrar
