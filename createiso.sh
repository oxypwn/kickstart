#!/bin/sh
ISO_NAME=centos63_boot.iso
# Remove the old iso.
#Ksdevice=eth0
rm -f $ISO_NAME
# Make the image.
mkisofs -o $ISO_NAME -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -T $PWD
