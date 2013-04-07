#!/bin/bash
curl -fsL ${REMOTE}/archlinux/post/${POSTSCRIPT} -o ${MNT}/${POSTSCRIPT} 

# Chroot to configure system
chmod u+x ${MNT}/${POSTSCRIPT}; arch-chroot ${MNT} /${POSTSCRIPT}
