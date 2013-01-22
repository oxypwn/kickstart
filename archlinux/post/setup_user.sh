#!/bin/bash

groupadd wireshark
groupadd vboxusers
groupadd kvm

useradd -m -g users -G audio,lp,optical,storage,video,games,power,scanner,network,wheel,sudo,sys,wireshark,vboxusers,kvm -s ${USERSHELL} ${USERNAME}
