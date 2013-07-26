#!/usr/bin/env bash

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi


_installpkg xorg xorg-server xorg-xinit xorg-utils xorg-server-utils xdotool xorg-xlsfonts xclip xorg-xclipboard xscreensaver
_installpkg firefox chromium feh fontforge scrot simple-scan unclutter mplayer gvfs gvfs-smb udevil
_installpkg dmenu dwm xfce4 xfce4-goodies
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
