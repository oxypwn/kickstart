#!/usr/bin/env/ bash
# Metasploit

if [ -z $REMOTE ]; then
    REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh")
fi


_installpkg ruby
git clone git://github.com/rapid7/metasploit-framework.git /home/${USERNAME}/pentest/metasploit-framework
