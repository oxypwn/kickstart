#!/bin/sh
# This module handles multitude users and will randomize passwords for all accounts.
# All accounts will be taken from an url and logged to /root/accounts.txt
# Upon first login users have to change passwords.
for user in $(/usr/bin/curl -s -L https://raw.github.com/pandrew/kickstart/master/users.txt | cat);do
    useradd -b /home -m $user
    pass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c8)
    echo "$user:$pass" >> /root/accounts.txt
    echo "$user:$pass" | chpasswd
    #-M 90 maximum number of days between password change
    #-W 60 set expiration warning days to N before password change is req.
    #-I 7 if user has not logged in N days before account is locked
    chage -M 90 -W 7 -I 7 -d 0 $user
done
