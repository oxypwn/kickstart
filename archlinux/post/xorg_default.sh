#!/bin/bash

_installpkg xorg-xinit xorg dwm feh simple-scan xpdf mplayer
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
