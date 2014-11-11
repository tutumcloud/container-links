#!/bin/bash

echo "=> Hosname:" $(hostname -I)
echo "=> Storing public key ..."
echo -e "${TUTUM_PUBLIC_KEY}" > /root/.ssh/authorized_keys
echo "=> Dumpping environment variables ..."
env > /server_env.txt
ls /server_env.txt
cat /server_env.txt
echo "=> Running ssh server ..."
exec /usr/sbin/sshd -D
