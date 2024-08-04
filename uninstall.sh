#!/bin/bash

if (( $EUID != 0 )); then
    echo "Run as root or with sudo"
    exit 1
fi

systemctl stop frpc.service
systemctl disable frpc.service
rm /lib/systemd/system/frpc.service

systemctl stop frps.service
systemctl disable frps.service
rm /lib/systemd/system/frps.service

rm -rf /opt/frp
