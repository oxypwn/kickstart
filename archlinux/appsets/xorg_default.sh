#!/bin/bash

_installpkg xorg xorg-server xorg-xinit xorg-utils xorg-server-utils xdotool xorg-xlsfonts xclip xorg-xclipboard xscreensaver
_installpkg feh scrot simple-scan unclutter mplayer gvfs
_installpkg dmenu dwm xfce4
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
