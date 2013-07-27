#!/usr/bin/env bash
cat > /usr/bin/sync.sh << EOF

SHELL=/usr/bin/bash
sleep 10
if [ "$(pidof rsync)" ]; then
    exit 0
else
    /usr/bin/rsync -aqzP -e "ssh -i /home/${USERNAME}/.ssh/${SYNCKEY}" \
    ${SYNCSOURCE} /home/${USERNAME}/sync \
    >> /var/log/sync.log 2>&1 && sudo exportfs -ra  &
fi

EOF


cat > /home/${USERNAME}/crontab << EOF

@reboot /home/${USERNAME}/sync.sh

EOF

crontab /home/${USERNAME}/crontab
