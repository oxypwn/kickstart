#!/usr/bin/env bash

groupadd wireshark
groupadd vboxusers
groupadd kvm

useradd -m -g ${GROUP} -G ${ADDTOGROUPS} -s ${USERSHELL} ${USERNAME}
