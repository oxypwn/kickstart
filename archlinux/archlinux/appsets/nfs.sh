#!/usr/bin/env bash
_installpkg nfs-utils


mkdir -p /home/${USERNAME}/sync
mkdir -p /srv/nfs/share
mount --bind /home/${USERNAME}/sync /srv/nfs/share

curl -fsL ${REMOTE}/conf/exports -o /etc/exports

systemctl enable rpc-idmapd.service
systemctl enable rpc-mountd.service
