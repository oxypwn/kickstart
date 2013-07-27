#!/usr/bin/env bash
#https://wiki.archlinux.org/index.php/Skype#Use_Skype_with_special_user
_installpkg skype

groupadd skype
useradd -m -g skype -G audio,video -s /bin/bash skype

cat > /home/skype/.bashrc << EOF
export DISPLAY=":0.0"
EOF
