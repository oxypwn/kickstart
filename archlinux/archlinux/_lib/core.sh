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

# DEFAULT REPOSITORY URL
# (probably not useful here if initialization script has already used it,
# but retained here for reference)

_defaultvalue REMOTE http://raw.github.com/pandrew/kickstart/master/archlinux

# DEFAULT CONFIG VALUES

_defaultvalue HOSTNAME archlinux
_defaultvalue USERSHELL /usr/bin/bash
_defaultvalue ADDTOGROUPS "users"
_defaultvalue FONT ter-116n
_defaultvalue FONT_MAP 8859-1
_defaultvalue LANGUAGE en_US.UTF-8
_defaultvalue KEYMAP us
_defaultvalue TIMEZONE Europe/Stockholm
_defaultvalue MODULES ""
# The HOOK="encrypt" might give warnings upon boot when you dont have any encrypted filesystem to decrypt.
_defaultvalue HOOKS "base udev autodetect block filesystems shutdown keyboard fsck keymap"
_defaultvalue KERNEL_PARAMS # "quiet" # set/used in FILESYSTEM,INIT,BOOTLOADER blocks
_defaultvalue INSTALL_DRIVE /dev/sda
_defaultvalue INIT_MODE systemd # systemd vs anything else. Blocks/helpers can check this to confirm systemd use

#TODO: REMOVE THIS #_defaultvalue PRIMARY_BOOTLOADER UEFI # UEFI or BIOS (case insensitive)

# CONFIG VALUES WHICH REMAIN UNDEFAULTED
# for reference - these remain unset if not already declared
# USERNAME, SYSTEMTYPE

# BLOCKS DEFAULTS 

_defaultvalue INSTALL pre/base
_defaultvalue HARDWARE ""
_defaultvalue TIME post/time_ntp_utc
_defaultvalue LOCALE post/locale
_defaultvalue SUDO post/sudo
_defaultvalue HOST post/host
_defaultvalue FILESYSTEM pre/filesystem
_defaultvalue RAMDISK post/ramdisk_default
_defaultvalue BOOTLOADER pre/grub
_defaultvalue NETWORK post/wired_wireless_default
_defaultvalue BLACKLIST post/blacklist
_defaultvalue FSTAB pre/fstab
_defaultvalue XORG ""
_defaultvalue AUDIO ""
_defaultvalue VIDEO ""
_defaultvalue SOUND ""
_defaultvalue POWER post/power_acpi
_defaultvalue SENSORS post/sensors
_defaultvalue DESKTOP ""
_defaultvalue USERS post/user
_defaultvalue AUTH post/auth
_defaultvalue APPSETS ""
_defaultvalue PACKAGES "git"
_defaultvalue AURPACKAGES ""

# ARCH PREP & SYSTEM INSTALL (PRE CHROOT)
if ! $INCHROOT; then
_load_efi_modules || true       # ATTEMPT TO LOAD EFIVARS, EVEN IF NOT USING EFI (REQUIRED)
_loadblock "${FILESYSTEM}"      # LOAD FILESYSTEM (FUNCTIONS AND VARIABLE DECLARATION ONLY)
_filesystem_pre_baseinstall     # FILESYSTEM PARTITION FORMAT MOUNT
_loadblock "${FSTAB}"     # LOAD FSTAB
_install_mirrorlist		# INSTALL MIRRORLIST TO LIVE AND CHROOT ENVIRONMENT
_loadblock "${INSTALL}"         # INSTALL ARCH
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
_loadblock "${APPSETS} appsets/packages appsets/aurpackages"
#_loadblock post/packages
#_loadblock post/aurpackages
_loadblock "${SUDO}"
_loadblock "${USERS}"
_loadblock "${MR_BOOTSTRAP+post/mr_bootstrap}"
_loadblock "${AUTH}"
_cleanup
fi

eject && reboot
