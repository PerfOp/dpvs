#!/bin/bash
##############################################################
# File Name: setup.sh
# Author:
# mail:
# Created Time: Thu Sep  4 05:32:42 2025
##############################################################
VIP=10.2.0.119
LIP=10.2.0.117
RS=10.2.0.105

sudo ./bin/dpip addr add ${VIP}/24 dev eth0
sudo ./bin/ipvsadm -A -t ${VIP}:80 -s rr
sudo ./bin/ipvsadm -a -t ${VIP}:80 -r ${RS}:80 -b

sudo ./bin/ipvsadm --add-laddr -z ${LIP} -t ${VIP}:80 -F eth0
