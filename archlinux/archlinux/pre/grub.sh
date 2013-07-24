#!/bin/bash
pacman -S --noconfirm grub-bios
modprobe dm-mod
grub-install --target=i386-pc --recheck --force ${INSTALL_DRIVE}
mkdir -p /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
