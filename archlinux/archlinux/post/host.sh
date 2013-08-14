#!/usr/bin/env bash
#
# HOST

echo ${HOSTNAME} > /etc/hostname;
hostname -F /etc/hostname;
sed -i "s/localhost\.localdomain/${HOSTNAME}/g" /etc/hosts;

