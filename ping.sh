#!/bin/bash
echo
if [ "$1" == "" ]
then
echo "Enter IP range"
echo " syntax: ./ping.sh 172.31.101 Enter ip with Network host only"
else
for ip in `seq 1 25`;do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":"
done
fi
