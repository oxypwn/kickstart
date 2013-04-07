#!/bin/bash
# VIRTUALBOX Fix smbus error
echo "blacklist i2c_piix4" >> /etc/modprobe.d/piix.conf
