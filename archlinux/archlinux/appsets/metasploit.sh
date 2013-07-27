#!/usr/bin/env bash
# Metasploit

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
    $USERNAME=$USER
fi


_installpkg ruby
git clone git://github.com/rapid7/metasploit-framework.git /home/${USERNAME}/pentest/metasploit-framework
