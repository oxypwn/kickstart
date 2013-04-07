#!/bin/bash

_installpkg xorg xorg-server xorg-xinit xorg-utils xorg-server-utils xdotool xorg-xlsfonts xclip xorg-xclipboard xscreensaver xcb-util-wm xcb-util xcb-util-keysyms
_installpkg chromium feh fontforge scrot simple-scan unclutter mplayer gvfs udevil 
_installpkg dmenu 
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
