#!/bin/bash
#
# INIT - systemd, pure
# as per the Arch Linux wiki page on systemd: https://wiki.archlinux.org/index.php/Systemd

_installpkg systemd
pacman -R --noconfirm sysvinit
pacman -S --noconfirm systemd-sysvcompat
set -e
#pacman -R --noconfirm initscripts || true # going for pure systemd
set +e

# NOT NEEDED IN PURE SYSTEMD MODE
# KERNEL_PARAMS="${KERNEL_PARAMS:+${KERNEL_PARAMS} }init=/bin/systemd"

systemctl enable syslog-ng.service

