#!/bin/bash
# NOT COMPLETE
# Install packages
_installpkg wireshark-cli tcpdump python-sqlalchemy python2-jinja python-pymongo libvirt python-bottle qemu
_installaur python-magic python-pefile

# Fix permissions for tcpdump
setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

# Add user
useradd -m -g users -G audio,lp,optical,storage,video,games,power,scanner,network,wheel,sys,vboxusers,kvm -s /bin/bash cuckoo

# Install cuckoo to /opt/cuckoo
git clone https://github.com/cuckoobox/cuckoo.git /opt/cuckoo

