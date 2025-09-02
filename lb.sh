#!/bin/bash

ipbin="./bin/dpip"
vsadmbin="./bin/ipvsadm"
nic="eth0"
#nicalias="enP6574s1"
nicalias="eth0"

dpip="10.2.0.117"
dpvip="10.2.0.119"
workloadip="10.2.0.105"

echo "Assinging the ip for the dpvs host..."
cmd="sudo $ipbin addr add $dpip/24 dev $nicalias"
echo $cmd
$cmd
#sudo $ipbin addr add $dpip/24 dev $nicalias

echo "Assinging the vip for the dpvs host..."
cmd="sudo $ipbin addr add $dpvip/24 dev $nicalias"
echo $cmd
$cmd

echo "Creating virtual service with the vip $dpip"
cmd="sudo $vsadmbin -A -t $dpvip:80 -s rr"
echo $cmd
$cmd

echo "Mapping the workload service ..."
cmd="sudo $vsadmbin -a -t $dpvip:80 -r $workloadip:80 -g"
echo $cmd
$cmd
