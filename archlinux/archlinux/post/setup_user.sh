#!/bin/bash

groupadd wireshark
groupadd vboxusers
groupadd kvm

useradd -m -g ${GROUP} -G ${GROUPS} -s ${USERSHELL} ${USERNAME}
