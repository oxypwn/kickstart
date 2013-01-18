#!/bin/bash
#
# LOCALE

_uncommentvalue ${LANGUAGE} /etc/locale.gen; locale-gen
export LANG=${LANGUAGE}; echo -e "LANG=${LANGUAGE}\nLC_COLLATE=C" > /etc/locale.conf

curl -fsL ${REMOTE}/svoraka5.map.gz -o /usr/share/kbd/keymaps/i386/dvorak/svoraka5.map.gz
echo -e "KEYMAP=${KEYMAP}\nFONT=${FONT}\nFONT_MAP=${FONT_MAP}" > /etc/vconsole.conf
#curl -fsL --create-dirs ${REMOTE}/svorak-a5-xkb  -o /usr/share/X11/xkb/symbols/svorak

