#!/usr/bin/env bash

_installpkg zsh rxvt-unicode vim tmux iptraf-ng dosfstools

# Install ssh
_installpkg openssh


curl -fsL ${REMOTE}/archlinux/conf/sshd_config -o /etc/ssh/sshd_config

systemctl enable sshd.service
systemctl enable sshd.socket

