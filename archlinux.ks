#!/bin/bash
# This is a test to build an unattended installation method for archlinux
# This code is in development and the ideas for this is taken from archblocks,
# ec2-debian-installer and kickstart/preseed.
# TODO
# implement logging function
# script -t 2> timings -a session -c ./archlinux.ks
# scriptreplay timing session
# Minimize amount of code and make it more human readable.
# If we get an error we should be able to fix it in the code and let 
# the install system redownload block if possible.
# RESPOSITORY ------------------------------------------------------------
#REMOTE=http://raw.github.com/pandrew/kickstart/master
REMOTE=http://192.168.1.76:8080
# CONFIG -----------------------------------------------------------------
HOSTNAME=brian
USERNAME=paul
USERSHELL=/bin/bash
FONT=ter-116n
FONT_MAP=8859-1
LANGUAGE=en_US.UTF-8
KEYMAP=svoraka5
TIMEZONE=Europe/Stockholm
MODULES="dm_mod dm_crypt aes_x86_64 ext2 ext4 vfat intel_agp drm i915"
#HOOKS="base udev autodetect pata scsi sata usb usbinput consolefont encrypt filesystems fsck shutdown"
# possible fix for occasional blank screen on resume? https://wiki.archlinux.org/index.php/Pm-utils#Blank_screen_issue



# EXTRA PACKAGES ---------------------------------------------------------
# if you don't want to create a new block, you can specify extra packages
# from official repos or AUR here (simple space separated list of packages)
PACKAGES="dosfstools git mplayer wireshark-cli transmission-cli wireshark-cli xpdf openssh handbrake-cli nmap simple-scan rxvt-unicode xterm vim xorg-xinit xorg dwm terminus-font"
AURPACKAGES="mr"

# EXECUTE ----------------------------------------------------------------
. <(curl -fsL "${REMOTE}/archlinux/_lib/helpers.sh"); _loadblock "_lib/core"
