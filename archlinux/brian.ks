#!/usr/bin/env bash
# http://is.gd/sEXLLU

REMOTE=http://raw.github.com/pandrew/kickstart/test/archlinux/
HOSTNAME=brian
USERNAME=pandrew
GROUP="users"
ADDTOGROUPS="audio,lp,optical,storage,video,games,power,scanner,network,wheel,sudo,sys,wireshark,vboxusers,kvm"
USERS_SHELL=zsh
FONT=ter-116n
FONT_MAP=8859-1
LANGUAGE=en_US.UTF-8
KEYMAP=svoraka5
TIMEZONE=Europe/Stockholm
MODULES="dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
HOOKS="base udev autodetect block keyboard consolefont encrypt filesystems fsck shutdown"
AUDIO=post/audio_alsa
APPSETS=""
PACKAGES=""
AURPACKAGES=""



#MR_BOOTSTRAP=https://raw.github.com/pandrew/pandrew-home/master/.mrconfig

# Source functions and run core
. <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh"); _loadblock "_lib/core"

