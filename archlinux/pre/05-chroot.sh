#!/bin/bash

# Chroot to configure system
[ -z $MOUNT_PATH ] && MOUNT_PATH=/mnt
arch-chroot $MOUNT_PATH /bin/bash

