#!/bin/ash
cd /usr/local/bin/
ls -la
# start the docker daemon
/usr/local/bin/dockerd-entrypoint.sh &

# start the ssh daemon
/usr/sbin/sshd -D
