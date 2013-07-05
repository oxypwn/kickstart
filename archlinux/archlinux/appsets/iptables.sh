#!/usr/bin/bash

cat > /etc/conf.d/iptables << EOF
IPTABLES_CONF=/etc/iptables/iptables.rules

EOF

systemctl enable iptables.service	
