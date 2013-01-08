#!/bin/bash
for i in (curl -fsL ${REMOTE}/archlinux/post/pacman-packages.txt); do
	pacman -S --noconfirm $i
done
