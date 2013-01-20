#!/bin/bash
echo "${USERNAME}:${USERNAME}" | chpasswd
passwd -e ${USERNAME}

echo "root:root" | chpasswd
passwd -e root

