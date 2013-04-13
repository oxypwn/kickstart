#!/bin/bash

groupadd wireshark
groupadd vboxusers
groupadd kvm

useradd -m -g users -G ${ADDTOGROUPS} -s ${USERSHELL} ${USERNAME}
