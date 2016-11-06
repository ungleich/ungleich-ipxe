#!/bin/bash

target=bin/undionly.kpxe

cat > /root/forward.ipxe << EOF
#!ipxe

dhcp
chain http://${HTTP_SERVER:-http-server}/pxelinux.0
EOF

cd /root/ipxe/src && make "$target" EMBED=/root/forward.ipxe && \
mv "$target"  /var/lib/tftpboot/pxelinux.0

in.tftpd --foreground --user root --verbose --secure /var/lib/tftpboot
