#!/usr/bin/env bash

groupadd wireshark
groupadd vboxusers
groupadd kvm


if [ $USERS_SHELL == "zsh" ]; then
	_installpkg zsh
else 
	USER_SHELL=bash
fi

useradd -m -g ${GROUP} -G ${ADDTOGROUPS} -s /usr/bin/${USERS_SHELL} ${USERNAME}
