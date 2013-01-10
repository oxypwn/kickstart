#!/bin/bash

# root password
#chage -d 0 root
echo "root:root" | chpasswd
passwd -e root
