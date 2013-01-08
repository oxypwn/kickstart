#!/bin/bash

HOSTNAME=stewie
LOCALE=en_US.UTF-8
KEYMAP=Dvorak
FONT=Lat2-Terminus16
FONT_MAP=88591_to_uni
HOOKS="base udev autodetect block filesystems usbinput fsck"
PACKAGES="xorg xorg-xinit dwm git vim"

echo $HOSTNAME > /etc/hostname
ln -s /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

echo "LANG=\"$LOCALE\"" > /etc/locale.conf
echo $KEYMAP > /etc/vconsole.conf
echo $FONT >> /etc/vconsole.conf
echo $FONT_MAP >> /etc/vconsole.conf

echo "sv_SE.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

sed -i "s/^HOOKS.*$/HOOKS=\"${HOOKS}\"/" /etc/mkinitcpio.conf
mkinitcpio -p linux

chage -d 0 root



