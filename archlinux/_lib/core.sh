#!/bin/bash
# ------------------------------------------------------------------------
# archblocks - modular Arch Linux install script
# ------------------------------------------------------------------------
# blocks/lib/core.sh - main installer execution sequence

# PREFLIGHT --------------------------------------------------------------

# buckle up
#set -o errexit

# check if we're in an IO redirect or incorrectly sourced script
[ ! -f "${0}" ] && echo "Don't run this directly from curl. Save to file first." && exit

# set mount point, temp directory, script values
MNT=/mnt; TMP=/tmp/archblocks; POSTSCRIPT="/postinstall.sh"

# get chroot status
[ -e "${POSTSCRIPT}" ] && INCHROOT=true || INCHROOT=false

# DEFAULT REPOSITORY URL -------------------------------------------------
# (probably not useful here if initialization script has already used it,
# but retained here for reference)

_defaultvalue REMOTE https://raw.github.com/altercation/archblocks/master

# DEFAULT CONFIG VALUES --------------------------------------------------

_defaultvalue HOSTNAME archlinux
_defaultvalue USERSHELL /bin/bash
_defaultvalue FONT ter-116n
_defaultvalue FONT_MAP 8859-1
_defaultvalue LANGUAGE en_US.UTF-8
_defaultvalue KEYMAP us
_defaultvalue TIMEZONE US/Pacific
_defaultvalue MODULES ""
_defaultvalue HOOKS "base udev autodetect block filesystems shutdown usbinput fsck keymap"
_defaultvalue KERNEL_PARAMS # "quiet" # set/used in FILESYSTEM,INIT,BOOTLOADER blocks
_defaultvalue AURHELPER packer
_defaultvalue INSTALL_DRIVE /dev/sda # this overrides any default value set in FILESYSTEM block
_defaultvalue INIT_MODE systemd # systemd vs anything else. Blocks/helpers can check this to confirm systemd use

#TODO: REMOVE THIS #_defaultvalue PRIMARY_BOOTLOADER UEFI # UEFI or BIOS (case insensitive)

# CONFIG VALUES WHICH REMAIN UNDEFAULTED ---------------------------------
# for reference - these remain unset if not already declared
# USERNAME, SYSTEMTYPE

# BLOCKS DEFAULTS --------------------------------------------------------

_defaultvalue INSTALL pre/install-base
_defaultvalue HARDWARE ""
_defaultvalue TIME post/time_ntp_utc # or, e.g. time_ntp_localtime
_defaultvalue SETLOCALE post/locale_default
_defaultvalue SUDO post/sudo_default
_defaultvalue HOST post/host_default
_defaultvalue FILESYSTEM pre/partition-format-mount
_defaultvalue RAMDISK post/ramdisk_default
_defaultvalue BOOTLOADER pre/bootloader-grub
_defaultvalue NETWORK post/wired_wireless_default
_defaultvalue BLACKLIST post/blacklist
_defaultvalue FSTAB pre/fstab
#_defaultvalue INIT init/systemd_pure
#_defaultvalue INIT=init/systemd_coexist
#_defaultvalue INIT=init/sysvinit_default
_defaultvalue XORG ""
_defaultvalue AUDIO ""
_defaultvalue VIDEO ""
_defaultvalue SOUND ""
_defaultvalue POWER post/power_acpi
_defaultvalue SENSORS post/sensors_default
_defaultvalue DESKTOP ""
_defaultvalue USERS "post/setup_user"
_defaultvalue AUTH "post/setup_acc"
_defaultvalue APPSETS ""
_defaultvalue PACKAGES "git"
_defaultvalue AURPACKAGES ""

# ARCH PREP & SYSTEM INSTALL (PRE CHROOT) --------------------------------
if ! $INCHROOT; then
#_initialwarning                 # WARN USER OF IMPENDING DOOM
#_setfont                        # SET FONT FOR PLEASANT INSTALL EXPERIENCE
_load_efi_modules || true       # ATTEMPT TO LOAD EFIVARS, EVEN IF NOT USING EFI (REQUIRED)
_loadblock "${FILESYSTEM}"      # LOAD FILESYSTEM (FUNCTIONS AND VARIABLE DECLARATION ONLY)
_filesystem_pre_baseinstall     # FILESYSTEM PARTITION FORMAT MOUNT
_loadblock "${FSTAB}"     # LOAD FSTAB
_install_mirrorlist		# INSTALL MIRRORLIST TO LIVE AND CHROOT ENVIRONMENT
_loadblock "${INSTALL}"         # INSTALL ARCH
_filesystem_post_baseinstall    # WRITE FSTAB/CRYPTTAB AND ANY OTHER POST INTALL FILESYSTEM CONFIG
#_filesystem_pre_chroot          # PROBABLY UNMOUNT OF BOOT IF INSTALLING UEFI MODE
_chroot_postscript              # CHROOT AND CONTINUE EXECUTION
fi

# ARCH CONFIG (POST CHROOT) ----------------------------------------------
if $INCHROOT; then
umount /tmp || _anykey "didn't unmount tmp..."
#pacman -Sy
_filesystem_post_chroot         # FILESYSTEM POST-CHROOT CONFIGURATION
#_systemd && _loadblock "post/systemd_default" # PURE SYSTEMD INSTALL
_loadblock "${SETLOCALE}"       # SET LOCALE
_loadblock "${TIME}"            # TIME
_loadblock "${HOST}"            # HOSTNAME
                                # DAEMONS
                                # INIT/SYSTEMD
_loadblock "${NETWORK}"         # NETWORKING
_loadblock "${AUDIO}"           # AUDIO
#_loadblock "${VIDEO}"           # VIDEO
#_loadblock "${SOUND}"           # SOUND
_loadblock "${POWER}"           # POWER
#_loadblock "${SENSORS}"         # SENSORS
#_loadblock "${KERNEL}"         # KERNEL
_loadblock "${RAMDISK}"         # RAMDISK
_loadblock "${BLACKLIST}"	# BLACKLIST
_loadblock "${BOOTLOADER}"      # BOOTLOADER
_loadblock "${SUDO}"
_loadblock "${USERS}"      # COMMON POST INSTALL ROUTINES
_loadblock "${XORG}"            # XORG
#_loadblock "${DESKTOP}"         # DESKTOP/WM/ETC
#_loadblock "${HARDWARE}"        # COMMON POST INSTALL ROUTINES
_loadblock "${APPSETS}"         # COMMON APPLICATION/UTILITY SETS
_installpkg ${PACKAGES}
_installaur ${AURPACKAGES}
_loadblock "${MR_BOOTSTRAP+post/mr_bootstrap}"
_loadblock "${AUTH}"
_cleanup
fi

