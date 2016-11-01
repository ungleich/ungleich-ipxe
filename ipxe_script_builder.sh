#!/bin/bash

cat > /root/forward.ipxe << EOF
#!ipxe

dhcp
chain http://${HTTP_SERVER:-http-server}/pxelinux.0
EOF

cd /root/ipxe/src && make bin/ipxe.iso EMBED=/root/forward.ipxe && \
mv /root/ipxe/src/bin/ipxe.iso /var/lib/tftpboot/pxelinux.0
rm /root/forward.ipxe

in.tftpd --foreground --user root --verbose --secure /var/lib/tftpboot
