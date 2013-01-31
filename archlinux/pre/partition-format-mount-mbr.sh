#!/bin/sh

set -e
PARTITION_BOOT_GRUB=1
PARTITION_ROOT=3
PARTITION_SWAP=2
LABEL_BOOT_GRUB=bootgrub
LABEL_SWAP=swap
LABEL_ROOT=root
MOUNT_PATH=/mnt
BOOT_SYSTEM_PARTITION=/boot/grub

_filesystem_pre_baseinstall () {
dd if=/dev/zero of=${INSTALL_DRIVE} bs=512 count=1

# create a 100MB boot 1GB Swap and the rest root on $INSTALL_DRIVE
fdisk ${INSTALL_DRIVE} << EOF
p
o
n
p


+100M
t
L
83
n
p


+1G
t
2
82
n
p



t
3
83
n
p


w
EOF

mkfs.ext3 -L "${LABEL_BOOT_GRUB}" ${INSTALL_DRIVE}${PARTITION_BOOT_GRUB}
mkfs.ext4 -L "${LABEL_ROOT}" ${INSTALL_DRIVE}${PARTITION_ROOT}
mkswap -L "${LABEL_SWAP}" ${INSTALL_DRIVE}${PARTITION_SWAP}
swapon ${INSTALL_DRIVE}${PARTITION_SWAP}


# Mount
mkdir -p ${MOUNT_PATH}
mount ${INSTALL_DRIVE}${PARTITION_ROOT} ${MOUNT_PATH}
mkdir -p ${MOUNT_PATH}${BOOT_SYSTEM_PARTITION}
mount -t ext3 ${INSTALL_DRIVE}${PARTITION_BOOT_GRUB} ${MOUNT_PATH}${BOOT_SYSTEM_PARTITION}
}

