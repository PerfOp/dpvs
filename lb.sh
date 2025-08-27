#!/bin/bash

ipbin="./bin/dpip"
vsadmbin="./bin/ipvsadm"
nic="eth1"
nicalias="enP29972s2"

dpip="10.2.1.118"
dpvip="10.2.1.200"
workloadip="10.2.1.106"

echo "Assinging the ip for the dpvs host..."
cmd="sudo $ipbin addr add $dpip/24 dev $nicalias"
echo $cmd
$cmd
#sudo $ipbin addr add $dpip/24 dev $nicalias

echo "Assinging the vip for the dpvs host..."
cmd="sudo $ipbin addr add $dpip/24 dev $nicalias"
echo $cmd
$cmd

echo "Creating virtual service with the vip $dpip"
cmd="sudo $vsadmbin -A -t $dpip:80 -s rr"
echo $cmd
$cmd

echo "Mapping the workload service ..."
cmd="sudo $vsadmbin -a -t $dpip:80 -r $workloadip:80 -m"
echo $cmd
$cmd
