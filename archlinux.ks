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
REMOTE=https://raw.github.com/altercation/archblocks/dev

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


INSTALL_DRIVE=/dev/sda1

# BLOCKS -----------------------------------------------------------------
TIME=common/time_chrony_utc
FILESYSTEM=filesystem/gpt_luks_passphrase_ext4
BOOTLOADER=bootloader/efi_gummiboot
NETWORK=network/wired_wireless_default

# EXECUTE ----------------------------------------------------------------
#. <(curl -fsL "${REMOTE}/blocks/_lib/helpers.sh"); _loadblock "_lib/core"

