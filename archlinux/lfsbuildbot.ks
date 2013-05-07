#!/bin/bash
# This is a test to build an unattended installation method for archlinux
# This code is in development and the ideas for this is taken from archblocks,
# ec2-debian-installer and kickstart/preseed.
# TODO
# implement logging function
# script -t 2> timings -a session -c ./archlinux.ks
# scriptreplay timing session
# Minimize amount of code and make it more human readable.
# RESPOSITORY ------------------------------------------------------------
REMOTE=http://raw.github.com/pandrew/kickstart/master
# CONFIG -----------------------------------------------------------------
HOSTNAME=lfsbuildbot01
USERNAME=pandrew
USERSHELL=/bin/zsh
FONT=ter-116n
FONT_MAP=8859-1
LANGUAGE=en_US.UTF-8
KEYMAP=svoraka5
TIMEZONE=Europe/Stockholm
MODULES="dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
HOOKS="base udev autodetect block keyboard consolefont encrypt filesystems fsck shutdown"
# possible fix for occasional blank screen on resume? https://wiki.archlinux.org/index.php/Pm-utils#Blank_screen_issue
AUDIO=post/audio_alsa
APPSETS="appsets/default"
# Default install drive is /dev/sda. Specify INSTALL_DRIVE to qemu

# EXTRA PACKAGES ---------------------------------------------------------
# if you don't want to create a new block, you can specify extra packages
# from official repos or AUR here (simple space separated list of packages)
PACKAGES="dosfstools zsh git rxvt-unicode xterm vim terminus-font"
AURPACKAGES="mr git-annex-bin dropbox"



MR_BOOTSTRAP=https://raw.github.com/pandrew/pandrew-home/master/.mrconfig

# EXECUTE ----------------------------------------------------------------
. <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh"); _loadblock "_lib/core"

