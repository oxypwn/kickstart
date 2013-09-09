#!/usr/bin/env bash
#
# HOST

# Lookup current ip against dns and if success set HOSTNAME to returned value.
IPADDR=`hostname -i`
LOOKUPIP=$(host ${IPADDR})
if [[ $? = 0 ]] ; then
    HOSTNAME=$(host `hostname -i` | gawk -F' ' ´{print $5}´)
fi


echo ${HOSTNAME} > /etc/hostname;
hostname -F /etc/hostname;
sed -i "s/localhost\.localdomain/${HOSTNAME}/g" /etc/hosts;

