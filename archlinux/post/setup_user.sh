#!/bin/bash
useradd -m -g users -G audio,lp,optical,storage,video,games,power,scanner,network,wheel,sys -s ${USERSHELL} ${USERNAME}
