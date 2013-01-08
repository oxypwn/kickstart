#!/bin/bash
arch-chroot /mnt pacman -S --noconfirm grub-bios
arch-chroot /mnt modprobe dm-mod
arch-chroot /mnt grub-install --target=i386-pc --recheck --force /dev/sda
arch-chroot /mnt mkdir -p /mnt/boot/grub/locale
arch-chroot /mnt cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
