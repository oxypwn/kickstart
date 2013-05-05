#!/bin/sh
_installpkg nfs-utils


mkdir -p /mnt/sync
mkdir -p /srv/nfs4/share
mount --bind /mnt/sync /srv/nfs4/share

curl -fsL ${REMOTE}/conf/exports -o /etc/exports

systemctl enable rpc-idmapd.service
systemctl enable rpc-mountd.service
