#!/bin/bash

NIC_NAME="eth0"
NIC_PCI="19ae:00:02.0"

# Get NIC state
STATE=$(cat /sys/class/net/$NIC_NAME/operstate)

if [ "$STATE" != "down" ]; then
    echo "$NIC_NAME is $STATE, closing..."
    ip link set $NIC_NAME down
    echo "$NIC_NAME was closed."
else
    echo "$NIC_NAME is down."
fi

./bin/dpvs -c ./dpvs.conf -- -a $NIC_PCI -l 0-4
