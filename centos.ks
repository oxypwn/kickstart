

#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Firewall configuration
firewall --disabled
### Install OS instead of upgrade
install

### Firstboot
firstboot --disable

### Use network installation
# scientific linux
#url --url="ftp://ftp.sunet.se/pub/Linux/distributions/scientific/6.3/x86_64/os/"
# centos
url --url="http://ftp.sunet.se/pub/Linux/distributions/centos/6.3/os/x86_64/"

### Root password
# To generate a password using MD5 alg. to suite rootpw:
# openssl passed -1 -salt "shaker" "your_password"
# rootpw --iscrypted $1$HFDgGGnA$5Fdxy9dn6aQ.jdu14DNxF0
rootpw ang100ice
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use text mode install
text
# System keyboard
keyboard dvorak
# System language
lang en_US
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
# Installation logging level
logging --level=info
# Reboot after installation
reboot --eject
# System services
services --enabled="sshd,vsftpd"
# System timezone
timezone  Europe/Stockholm
# Network information
network  --bootproto=dhcp --device=eth0 --onboot=on --hostname client
network  --bootproto=static --device=eth1 --ip=1.1.1.2 --onboot=on --netmask=255.255.255.0

# System bootloader configuration
bootloader --location=mbr
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel 
# Disk partitioning information
part pv.1 --grow --size=1
part /boot --fstype="ext2" --size=300
part / --asprimary --fstype="ext4" --grow --maxsize=4000 --size=2000
part /home --asprimary --fstype="ext4" --grow --size=1
part swap --fstype="swap" --size=500


#adding initial user
#user --name=user --password=1234	


%packages --nobase --excludedocs
yum
rpm
openssh
vsftpd
emacs-nox
iptraf
%end

%pre
%end

%post
###variables
export pullfrom=192.168.1.76:8000
export server=1.1.1.1
###adding users
for i in $(/usr/bin/curl -s -L https://raw.github.com/pandrew/kickstart/users.txt | cat);do
    useradd -b /home -m  $i 
    echo "$i:$i" | chpasswd
    chage -d 0 $i
done

#mv /boot/grub/grub.conf /boot/grub/grub.conf.bac
#sed '/hiddenmenu/d' /boot/grub/grub.conf.bac > /boot/grub/grub.conf
#grub-install

#yum update -y


#chage -d 0 root
%end
