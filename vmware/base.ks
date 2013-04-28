# Sample kickstart for ESXi 5.1
# William Lam
# www.virtuallyghetto.com
#########################################
 
accepteula
install --firstdisk --overwritevmfs
rootpw vmware123
reboot
 
%include /tmp/networkconfig
 
%pre --interpreter=busybox
 
# extract network info from bootup
VMK_INT="vmk0"
VMK_LINE=$(localcli network ip interface ipv4 get | grep "${VMK_INT}")
IPADDR=$(echo "${VMK_LINE}" | awk '{print $2}')
NETMASK=$(echo "${VMK_LINE}" | awk '{print $3}')
GATEWAY=$(localcli network ip route ipv4 list | grep default | awk '{print $3}')
DNS="172.30.0.100,172.30.0.200"
HOSTNAME=$(nslookup "${IPADDR}" | grep Address | awk '{print $4}' | tail -1)
 
echo "network --bootproto=static --addvmportgroup=false --device=vmnic0 --ip=${IPADDR} --netmask=${NETMASK} --gateway=${GATEWAY} --nameserver=${DNS} --hostname=${HOSTNAME}" > /tmp/networkconfig
 
%firstboot --interpreter=busybox
 
# enable VHV (Virtual Hardware Virtualization to run nested 64bit Guests + Hyper-V VM)
grep -i "vhv.enable" /etc/vmware/config || echo "vhv.enable = \"TRUE\"" >> /etc/vmware/config
 
# enable & start remote ESXi Shell  (SSH)
vim-cmd hostsvc/enable_ssh
vim-cmd hostsvc/start_ssh
 
# enable & start ESXi Shell (TSM)
vim-cmd hostsvc/enable_esx_shell
vim-cmd hostsvc/start_esx_shell
 
# supress ESXi Shell shell warning - Thanks to Duncan (http://www.yellow-bricks.com/2011/07/21/esxi-5-suppressing-the-localremote-shell-warning/)
esxcli system settings advanced set -o /UserVars/SuppressShellWarning -i 1
 
# ESXi Shell interactive idle time logout
esxcli system settings advanced set -o /UserVars/ESXiShellInteractiveTimeOut -i 3600
 
# Change the default ESXi Admins group "ESX Admins" to a custom one "Ghetto ESXI Admins" for AD
vim-cmd hostsvc/advopt/update Config.HostAgent.plugins.hostsvc.esxAdminsGroup string "Ghetto ESXi Admins"
 
# Users that will have full access to DCUI even if they don't have admin permssions on ESXi host
vim-cmd hostsvc/advopt/update DCUI.Access string root,william,tuan
 
# Block VM guest BPDU packets, global configuration
esxcli system settings advanced set -o /Net/BlockGuestBPDU -i 1
 
# copy SSH authorized keys & overwrite existing
wget http://air.primp-industries.com/esxi5/id_dsa.pub -O /etc/ssh/keys-root/authorized_keys
 
# disable SSH keys - uncomment the next section
# sed -i 's/AuthorizedKeysFile*/#AuthorizedKeysFile/g' /etc/ssh/sshd_config
 
# rename local datastore to something more meaningful
vim-cmd hostsvc/datastore/rename datastore1 "$(hostname -s)-local-storage-1"
 
# assign license
vim-cmd vimsvc/license --set AAAAA-BBBBB-CCCCC-DDDDD-EEEEE
 
## SATP CONFIGURATIONS ##
esxcli storage nmp satp set --satp VMW_SATP_SYMM --default-psp VMW_PSP_RR
esxcli storage nmp satp set --satp VMW_SATP_DEFAULT_AA --default-psp VMW_PSP_RR
 
###########################
## vSwitch configuration ##
###########################
 
#####################################################
# vSwitch0 : Active->vmnic0,vmnic1 Standby->vmnic2
#       failback: yes
#       faildectection: beacon
#       load balancing: portid
#       notify switches: yes
#       avg bw: 1000000 Kbps
#       peak bw: 1000000 Kbps
#       burst size: 819200 KBps
#       allow forged transmits: yes
#       allow mac change: no
#       allow promiscuous no
#       cdp status: both
 
# attach vmnic1,vmnic2 to vSwitch0
esxcli network vswitch standard uplink add --uplink-name vmnic1 --vswitch-name vSwitch0
esxcli network vswitch standard uplink add --uplink-name vmnic2 --vswitch-name vSwitch0
 
# configure portgroup
esxcli network vswitch standard portgroup add --portgroup-name VMNetwork1 --vswitch-name vSwitch0
esxcli network vswitch standard portgroup set --portgroup-name VMNetwork1 --vlan-id 100
esxcli network vswitch standard portgroup add --portgroup-name VMNetwork2 --vswitch-name vSwitch0
esxcli network vswitch standard portgroup set --portgroup-name VMNetwork2 --vlan-id 200
esxcli network vswitch standard portgroup add --portgroup-name VMNetwork3 --vswitch-name vSwitch0
esxcli network vswitch standard portgroup set --portgroup-name VMNetwork3 --vlan-id 333
 
# configure cdp
esxcli network vswitch standard set --cdp-status both --vswitch-name vSwitch1
 
### FAILOVER CONFIGURATIONS ###
 
# configure active and standby uplinks for vSwitch0
esxcli network vswitch standard policy failover set --active-uplinks vmnic0,vmnic1 --standby-uplinks vmnic2 --vswitch-name vSwitch0
 
# configure failure detection + load balancing (could have appended to previous line)
esxcli network vswitch standard policy failover set --failback yes --failure-detection beacon --load-balancing portid --notify-switches yes --vswitch-name vSwitch0
 
### SECURITY CONFIGURATION ###
esxcli network vswitch standard policy security set --allow-forged-transmits yes --allow-mac-change no --allow-promiscuous no --vswitch-name vSwitch0
 
### SHAPING CONFIGURATION ###
esxcli network vswitch standard policy shaping set --enabled yes --avg-bandwidth 100000 --peak-bandwidth 100000 --burst-size 819200 --vswitch-name vSwitch0
 
#####################################################
# vSwitch1 : Active->vmnic3,vmnic4 Standby->vmnic5
#       failback: no
#       faildectection: link
#       load balancing: mac
#       notify switches: no
#       allow forged transmits: no
#       allow mac change: no
#       allow promiscuous no
#       cdp status: listen
#       mtu: 9000
 
# add vSwitch1
esxcli network vswitch standard add --ports 256 --vswitch-name vSwitch1
 
# attach vmnic3,4,5 to vSwitch0
esxcli network vswitch standard uplink add --uplink-name vmnic3 --vswitch-name vSwitch1
esxcli network vswitch standard uplink add --uplink-name vmnic4 --vswitch-name vSwitch1
esxcli network vswitch standard uplink add --uplink-name vmnic5 --vswitch-name vSwitch1
 
# configure mtu + cdp
esxcli network vswitch standard set --mtu 9000 --cdp-status listen --vswitch-name vSwitch1
 
# configure portgroup
esxcli network vswitch standard portgroup add --portgroup-name NFS --vswitch-name vSwitch1
esxcli network vswitch standard portgroup add --portgroup-name FT_VMOTION --vswitch-name vSwitch1
esxcli network vswitch standard portgroup add --portgroup-name VSPHERE_REPLICATION --vswitch-name vSwitch1
 
### FAILOVER CONFIGURATIONS ###
 
# configure active and standby uplinks for vSwitch1
esxcli network vswitch standard policy failover set --active-uplinks vmnic3,vmnic4 --standby-uplinks vmnic5 --vswitch-name vSwitch1
 
# configure failure detection + load balancing (could have appended to previous line)
esxcli network vswitch standard policy failover set --failback no --failure-detection link --load-balancing mac --notify-switches no --vswitch-name vSwitch1
 
### SECURITY CONFIGURATION ###
esxcli network vswitch standard policy security set --allow-forged-transmits no --allow-mac-change no --allow-promiscuous no --vswitch-name vSwitch1
 
# configure vmkernel interface for NFS traffic, FT_VMOTION and VSPHERE_REPLICATION traffic
VMK0_IPADDR=$(esxcli network ip interface ipv4 get | grep vmk0 | awk '{print $2}')
VMK1_IPADDR=$(echo ${VMK0_IPADDR} | awk '{print $1".51."$3"."$4}' FS=.)
VMK2_IPADDR=10.10.0.2
VMK3_IPADDR=10.20.0.2
esxcli network ip interface add --interface-name vmk1 --mtu 9000 --portgroup-name NFS
esxcli network ip interface ipv4 set --interface-name vmk1 --ipv4 ${VMK1_IPADDR} --netmask 255.255.255.0 --type static
esxcli network ip interface add --interface-name vmk2 --mtu 9000 --portgroup-name FT_VMOTION
esxcli network ip interface ipv4 set --interface-name vmk2 --ipv4 ${VMK2_IPADDR} --netmask 255.255.255.0 --type static
esxcli network ip interface add --interface-name vmk3 --mtu 9000 --portgroup-name VSPHERE_REPLICATION
esxcli network ip interface ipv4 set --interface-name vmk3 --ipv4 ${VMK3_IPADDR} --netmask 255.255.255.0 --type static
 
# Configure VMkernel traffic type (Management, VMotion, faultToleranceLogging, vSphereReplication)
esxcli network ip interface tag add -i vmk2 -t Management
esxcli network ip interface tag add -i vmk2 -t VMotion
esxcli network ip interface tag add -i vmk2 -t faultToleranceLogging
esxcli network ip interface tag add -i vmk3 -t vSphereReplication
 
# Configure VMkernel routes
esxcli network ip route ipv4 add -n 10.20.183/24 -g 172.30.0.1
esxcli network ip route ipv4 add -n 10.20.182/24 -g 172.30.0.1
 
# Disable IPv6 for VMkernel interfaces
esxcli system module parameters set -m tcpip3 -p ipv6=0
 
### MOUNT NFS DATASTORE ###
esxcli storage nfs add --host 172.51.0.200 --share /volumes/Primp/primp-6 --volume-name himalaya-NFS-primp-6
 
### ADV CONFIGURATIONS ###
esxcli system settings advanced set --option /Net/TcpipHeapSize --int-value 30
esxcli system settings advanced set --option /Net/TcpipHeapMax --int-value 120
esxcli system settings advanced set --option /NFS/HeartbeatMaxFailures --int-value 10
esxcli system settings advanced set --option /NFS/HeartbeatFrequency --int-value 20
esxcli system settings advanced set --option /NFS/HeartbeatTimeout --int-value 10
esxcli system settings advanced set --option /NFS/MaxVolumes --int-value 128
 
### SYSLOG CONFIGURATION ###
esxcli system syslog config set --default-rotate 20 --loghost vcenter50-3.primp-industries.com:514,udp://vcenter50-3.primp-industries.com:514,ssl://vcenter50-3.primp-industries.com:1514,udp://vcenter50-3.primp-industries.com:514,udp://vcenter50-3.primp-industries.com:514,ssl://vcenter50-3.primp-industries.com:1514,ssl://vcenter50-3.primp-industries.com:1514
 
# change the individual syslog rotation count
esxcli system syslog config logger set --id=hostd --rotate=20 --size=2048
esxcli system syslog config logger set --id=vmkernel --rotate=20 --size=2048
esxcli system syslog config logger set --id=fdm --rotate=20
esxcli system syslog config logger set --id=vpxa --rotate=20
 
### NTP CONFIGURATIONS ###
cat > /etc/ntp.conf << __NTP_CONFIG__
restrict default kod nomodify notrap noquerynopeer
restrict 127.0.0.1
server 0.vmware.pool.ntp.org
server 1.vmware.pool.ntp.org
__NTP_CONFIG__
/sbin/chkconfig ntpd on
 
### FIREWALL CONFIGURATION ###
 
# enable firewall
esxcli network firewall set --default-action false --enabled yes
 
# services to enable by default
FIREWALL_SERVICES="syslog sshClient ntpClient updateManager httpClient netdump"
for SERVICE in ${FIREWALL_SERVICES}
do
 esxcli network firewall ruleset set --ruleset-id ${SERVICE} --enabled yes
done
 
# backup ESXi configuration to persist changes
/sbin/auto-backup.sh
 
# enter maintenance mode
esxcli system maintenanceMode set -e true
 
# copy %first boot script logs to persisted datastore
cp /var/log/hostd.log "/vmfs/volumes/$(hostname -s)-local-storage-1/firstboot-hostd.log"
cp /var/log/esxi_install.log "/vmfs/volumes/$(hostname -s)-local-storage-1/firstboot-esxi_install.log"
 
# Needed for configuration changes that could not be performed in esxcli
esxcli system shutdown reboot -d 60 -r "rebooting after host configurations"
