#!/bin/bash
# This is a test to build an unattended installation method for archlinux
# This code is in development and the ideas for this is taken from archblocks,
# ec2-debian-installer and kickstart/preseed.
# TODO
# Define static variables here. Will cleanup interaction with user.
# Minimize amount of code and make it more human readable.
# Specify what block/scripts/post/pre/anything to load from within this file.
# Dont chainload via libs as this file define what scripts to execute and not to execute.
# Prepend scripts with distribution name to tell reader/user that script is built for distribution.
# In all mimic behaviour of arch linux install on paper.
# RESPOSITORY ------------------------------------------------------------
REMOTE=https://raw.github.com/pandrew/kickstart/master

# CONFIG -----------------------------------------------------------------
HOSTNAME=tau
USERNAME=es
USERSHELL=/bin/bash
FONT=Lat2-Terminus16
FONT_MAP=8859-1_to_uni
LANGUAGE=en_US.UTF-8
KEYMAP=us
TIMEZONE=US/Pacific
MODULES="dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
#HOOKS="base udev autodetect pata scsi sata usb usbinput consolefont encrypt filesystems fsck shutdown"
# possible fix for occasional blank screen on resume? https://wiki.archlinux.org/index.php/Pm-utils#Blank_screen_issue
HOOKS="base udev autodetect pata scsi sata usb usbinput consolefont encrypt filesystems fsck shutdown"




# Execute in order
curl -fsL "${REMOTE}/archlinux/pre/01-partition-format-mount.sh" | bash
# Ensure correct mirrors is installed
# https://www.archlinux.org/mirrorlist/
curl -fsL "${REMOTE}/archlinux/pre/02-mirrorlist.sh" -o /etc/pacman.d/mirrorlist
# Intall base
curl -fsL "${REMOTE}/archlinux/pre/04-install-base.sh" | bash


# Refresh packages
pacman -Sy
