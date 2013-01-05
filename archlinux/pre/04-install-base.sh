#!/bin/bash
# Install base using pacstrap

# Update packages
pacman -Syu
MOUNT_PATH=/mnt
pacstrap $MOUNT_PATH base base-devel
