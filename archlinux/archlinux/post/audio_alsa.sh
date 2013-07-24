#!/usr/bin/env bash
#
# alsa sound
# ------------------------------------------------------------------------

_installpkg alsa-utils alsa-plugins

systemctl enable alsa-store.service
systemctl enable alsa-restore.service

# if alsamixer isn't working, try alsamixer -Dhw and speaker-test -Dhw -c 2


