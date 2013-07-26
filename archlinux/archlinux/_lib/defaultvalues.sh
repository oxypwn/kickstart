#!/usr/bin/env bash

# DEFAULT CONFIG VALUES
_defaultvalue REMOTE http://raw.github.com/pandrew/kickstart/master/archlinux
_defaultvalue USERNAME user
_defaultvalue HOSTNAME archlinux
_defaultvalue USERS_SHELL bash
_defaultvalue ADDTOGROUPS "users"
_defaultvalue FONT ter-116n
_defaultvalue FONT_MAP 8859-1
_defaultvalue LANGUAGE en_US.UTF-8
_defaultvalue KEYMAP us
_defaultvalue TIMEZONE Europe/Stockholm
_defaultvalue MODULES ""
_defaultvalue HOOKS "base udev autodetect block filesystems shutdown keyboard fsck keymap"
_defaultvalue KERNEL_PARAMS # "quiet" # set/used in FILESYSTEM,INIT,BOOTLOADER blocks
_defaultvalue INSTALL_DRIVE /dev/sda
_defaultvalue INIT_MODE systemd # systemd vs anything else. Blocks/helpers can check this to confirm systemd use
_defaultvalue PACSTRAP pre/pacstrap
_defaultvalue HARDWARE ""
_defaultvalue TIME post/time_ntp_utc
_defaultvalue LOCALE post/locale
_defaultvalue SUDO post/sudo
_defaultvalue HOST post/host
_defaultvalue SERVICES services/ssh
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
_defaultvalue APPSETS appsets/default
_defaultvalue PACKAGES "git"
_defaultvalue AURPACKAGES ""

