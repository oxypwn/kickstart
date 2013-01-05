#!/bin/bash
# Install base using pacstrap

# Update packages
pacman -Syu
[ -z $MOUNT_PATH ] && MOUNT_PATH=/mnt
pacstrap  ${MOUNT_PATH} base base-devel
