#!/bin/bash
cat > /home/${USERNAME}/sync.sh << EOF

SHELL=/bin/bash
sleep 10
if [ "$(pidof rsync)" ]; then
    exit 0
else
    /usr/bin/rsync -aqzP -e "ssh -i /home/${USERNAME}/.ssh/${SYNCKEY}" \
    ${SYNCSOURCE} /home/${USERNAME}/sync \
    >> /home/${USERNAME}/log 2>&1 && sudo exportfs -ra  &
fi

EOF


cat > /home/${USERNAME}/crontab << EOF

@reboot /home/${USERNAME}/sync.sh

EOF

crontab /home/${USERNAME}/crontab
