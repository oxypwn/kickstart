#!/bin/bash
apt-get install curl -y
for i in $(/usr/bin/curl -s -L https://raw.github.com/pandrew/linux-bootstrap/debian/debian_packages | cat);do
    apt-get install $i -y
done
