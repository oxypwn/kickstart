#!/bin/bash

[ -z $MOUNT_PATH ] && MOUNT_PATH=/mnt
mkdir -p $MOUNT_PATH/etc

LABEL_BIOS_GPT=biosgpt
LABEL_BOOT_GRUB=bootgrub
LABEL_SWAP=swap
LABEL_ROOT=root
BOOT_SYSTEM_PARTITION=/boot/grub

_filesystem_post_baseinstall ()
{
cat > ${MOUNT_PATH}/etc/fstab <<FSTAB_EOF
# /etc/fstab: static file system information
#
# <file system>             <dir>       <type>  <options>                   <dump>  <pass>
tmpfs                       /tmp        tmpfs   nodev,nosuid                0       0
#/dev/disk/by-partlabel/${LABEL_BOOT_EFI}       $BOOT_SYSTEM_PARTITION   vfat    rw,relatime,discard     0   2
/dev/disk/by-partlabel/${LABEL_BOOT_GRUB}        $BOOT_SYSTEM_PARTITION   vfat    rw,relatime,discard,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro    0 2
/dev/disk/by-partlabel/${LABEL_SWAP}            none        swap    defaults,discard                    0   0
/dev/disk/by-partlabel/${LABEL_ROOT}            /           ext4    rw,relatime,data=ordered,discard    0   1
/mnt/sync /srv/nfs4/share  none   bind   0   0
FSTAB_EOF
}
