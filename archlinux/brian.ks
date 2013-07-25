#!/usr/bin/env bash
# http://is.gd/sEXLLU
# RESPOSITORY ------------------------------------------------------------
REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
# CONFIG -----------------------------------------------------------------
HOSTNAME=brian
USERNAME=pandrew
GROUP="users"
ADDTOGROUPS="audio,lp,optical,storage,video,games,power,scanner,network,wheel,sudo,sys,wireshark,vboxusers,kvm"
USERSHELL=/usr/bin/zsh
FONT=ter-116n
FONT_MAP=8859-1
LANGUAGE=en_US.UTF-8
KEYMAP=svoraka5
TIMEZONE=Europe/Stockholm
MODULES="dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
HOOKS="base udev autodetect block keyboard consolefont encrypt filesystems fsck shutdown"
# possible fix for occasional blank screen on resume? https://wiki.archlinux.org/index.php/Pm-utils#Blank_screen_issue
AUDIO=post/audio_alsa
APPSETS=""
# Default install drive is /dev/sda. Specify INSTALL_DRIVE to qemu

# EXTRA PACKAGES ---------------------------------------------------------
# if you don't want to create a new block, you can specify extra packages
# from official repos or AUR here (simple space separated list of packages)
PACKAGES=""
AURPACKAGES=""



MR_BOOTSTRAP=https://raw.github.com/pandrew/pandrew-home/master/.mrconfig

# EXECUTE ----------------------------------------------------------------
. <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh"); _loadblock "_lib/core"

