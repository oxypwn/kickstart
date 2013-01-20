#!/bin/bash

# Install virtualbox

_installpkg virtualbox qt
/usr/bin/curl --create-dir -fsL ${REMOTE}/archlinux/conf/virtualbox.conf -o /etc/modules-load.d/virtualbox.conf
#cat > /etc/modules-load.d/conf/virtualbox.conf << EOF
#vboxdrv
#vboxnetadp
#vboxnetflt
#EOF
