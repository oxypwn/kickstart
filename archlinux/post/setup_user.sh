#!/bin/bash
useradd -m -g users -G audio,lp,optical,storage,video,games,power,scanner,network,wheel,sys -s ${USERSHELL} ${USERNAME}
# set dummy password
#passwd -p 1234 ${USERNAME}
echo "${USERNAME}:${USERNAME}" | chpasswd
passwd -e ${USERNAME}
