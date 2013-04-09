#!/bin/bash
# This is a test to build an unattended installation method for archlinux
# This code is in development and the ideas for this is taken from archblocks,
# ec2-debian-installer and kickstart/preseed.
# https://mailman.archlinux.org/mailman/listinfo/arch-releng
# implement logging function
# script -t 2> timings -a session -c ./archlinux.ks
# scriptreplay timing session
# RESPOSITORY ------------------------------------------------------------
REMOTE=http://raw.github.com/pandrew/kickstart/master/archlinux
# CONFIG -----------------------------------------------------------------
HOSTNAME=stewie
USERNAME=pandrew
USERSHELL=/bin/zsh
FONT=ter-116n
FONT_MAP=8859-1
LANGUAGE=en_US.UTF-8
KEYMAP=svoraka5
TIMEZONE=Europe/Stockholm
MODULES="virtio_blk virtio_pci virtio_net dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
#HOOKS="base udev autodetect block usbinput consolefont encrypt filesystems fsck shutdown"
# The HOOK="encrypt" might give warnings upon boot when you dont have any encrypted filesystem to decrypt.
HOOKS="base udev autodetect block keyboard consolefont filesystems fsck shutdown"
# possible fix for occasional blank screen on resume? https://wiki.archlinux.org/index.php/Pm-utils#Blank_screen_issue
AUDIO=post/audio_alsa
APPSETS="appsets/xorg_default appsets/mutt  appsets/virtual appsets/office"

# EXTRA PACKAGES ---------------------------------------------------------
# if you don't want to create a new block, you can specify extra packages
# from official repos or AUR here (simple space separated list of packages)
PACKAGES="dosfstools zsh git transmission-cli openssh handbrake-cli rxvt-unicode xterm vim terminus-font"
AURPACKAGES="mr git-annex-bin dropbox"



MR_BOOTSTRAP=https://raw.github.com/pandrew/pandrew-home/master/.mrconfig

# EXECUTE ----------------------------------------------------------------
. <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh"); _loadblock "_lib/core"

