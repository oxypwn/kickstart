#!/bin/bash
# Install base using pacstrap

[ -z $MOUNT_PATH ] && MOUNT_PATH=/mnt
pacstrap -i ${MOUNT_PATH} base base-devel
