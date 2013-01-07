#!/bin/bash
REMOTE=http://192.168.1.76:8080
curl -fsL $REMOTE/archlinux/post/01-postinstall.sh -o /mnt/01-postinstall.sh 
chmod u+x /mnt/01-postinstall.sh

# Chroot to configure system
[ -z $MOUNT_PATH ] && MOUNT_PATH=/mnt
arch-chroot $MOUNT_PATH /01-postinstall.sh
# We need to fetch a postinstall script to continue configuration and installation.
# ../post/01-postinstall.sh
