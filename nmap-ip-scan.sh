#!/bin/bash
echo "Scanning ip from 172.31.101.0/22"
./ping.sh 172.31.101 > iplist.txt
echo "nmap scanning"
nmap -sV -Pn -iL iplist.txt -oN Nmap-Output.txt
