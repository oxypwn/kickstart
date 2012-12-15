#!/bin/sh
# This module handles encryption of system using cryptsetup and luks
#
# This is in worki in progress.
# Generate the keyfile:
# dd if=/dev/random of=/etc/keys/sda1_key bs=1 count=32
