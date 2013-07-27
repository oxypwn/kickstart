#!/usr/bin/env bash
# alsa sound

if [ -z $REMOTE ]; then
    REMOTE=https://raw.github.com/pandrew/kickstart/master/archlinux/
    . <(curl -fsL "${REMOTE}/archlinux/_lib/functions.sh")
fi

_installpkg alsa-utils alsa-plugins

systemctl enable alsa-store.service
systemctl enable alsa-restore.service

# if alsamixer isn't working, try alsamixer -Dhw and speaker-test -Dhw -c 2


