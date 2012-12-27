#!/bin/bash

[ -z $HOSTNAME ] && HOSTNAME=stewie
echo ${HOSTNAME} > /etc/hostname;
sed -i "s/localhost\.localdomain/${HOSTNAME}/g" /etc/hosts;
