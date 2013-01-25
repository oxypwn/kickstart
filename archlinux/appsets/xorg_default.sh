#!/bin/bash


_installpkg unclutter xorg-xinit xorg xdotool xclpi gedit feh scrot simple-scan unclutter mplayer
_installpgk dmenu dwm xfce4
curl -fsL ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak
