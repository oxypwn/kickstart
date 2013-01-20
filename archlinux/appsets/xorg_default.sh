#!/bin/bash

_installpkg xorg-xinit xorg dwm dmenu gedit feh scrot simple-scan xpdf mplayer
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
