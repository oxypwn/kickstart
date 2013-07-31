#!/usr/bin/env bash
# ------------------------------------------------------------------------
# archblocks - modular Arch Linux install script
# ------------------------------------------------------------------------
# blocks/lib/core.sh - main installer execution sequence

# PREFLIGHT

# buckle up
#set -o errexit

# check if we're in an IO redirect or incorrectly sourced script
[ ! -f "${0}" ] && echo "Don't run this directly from curl. Save to file first." && exit

# set mount point, temp directory, script values
MNT=/mnt; TMP=/tmp/archblocks; POSTSCRIPT="/postinstall.sh"

# get chroot status
[ -e "${POSTSCRIPT}" ] && INCHROOT=true || INCHROOT=false

# Load default values
_loadblock "_lib/defaultvalues"

# ARCH PREP & SYSTEM INSTALL (PRE CHROOT)
if ! $INCHROOT; then
_load_efi_modules || true       # ATTEMPT TO LOAD EFIVARS, EVEN IF NOT USING EFI (REQUIRED)
_loadblock "${FILESYSTEM}"      # LOAD FILESYSTEM (FUNCTIONS AND VARIABLE DECLARATION ONLY)
_filesystem_pre_baseinstall     # FILESYSTEM PARTITION FORMAT MOUNT
_loadblock "${FSTAB}"     # LOAD FSTAB
_install_mirrorlist		# INSTALL MIRRORLIST TO LIVE AND CHROOT ENVIRONMENT
_loadblock "${PACSTRAP}"         # PACSTRAP
_filesystem_post_baseinstall    # WRITE FSTAB/CRYPTTAB AND ANY OTHER POST INTALL FILESYSTEM CONFIG
_chroot_postscript              # CHROOT AND CONTINUE EXECUTION
fi

# ARCH CONFIG (POST CHROOT)
if $INCHROOT; then
umount /tmp || _anykey "didn't unmount tmp..."
_filesystem_post_chroot
_loadblock "${LOCALE}"
_loadblock "${TIME}"
_loadblock "${HOST}"
_loadblock "${NETWORK}"
_loadblock "${NETWORK_PROFILE}"
_loadblock "${AUDIO}"
_loadblock "${VIDEO}"
_loadblock "${SOUND}"
_loadblock "${POWER}"
_loadblock "${SENSORS}"
#_loadblock "${KERNEL}"
_loadblock "${RAMDISK}"
_loadblock "${BLACKLIST}"
_loadblock "${BOOTLOADER}"
_loadblock "${XORG}"
#_loadblock "${DESKTOP}"
#_loadblock "${HARDWARE}" 
_loadblock "${SUDO}"
_loadblock "${APPSETS} appsets/default"
_installpkg "${PACKAGES}"
_installaur "${AURPACKAGES}"
_loadblock "${SERVICES}"
_loadblock "${USERS}"
_mrbootstrap "${MR_BOOTSTRAP}"
_loadblock "${AUTH}"
_cleanup
fi

eject && reboot || reboot
