#!/usr/bin/env bash
# Reader

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi



_installpkg newsbeuter zathura cups zathura-pdf-mupdf unrar
