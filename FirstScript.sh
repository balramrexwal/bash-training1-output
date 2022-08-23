#!/bin/bash
echo "First Script "
echo "1.Ping Sweep 25 ips from 172.31.101"
echo "2.nmap scan to 172.31.101 "
echo "3.SSH brute force"
echo "0.Exit"
echo -n "choice: "
function menu()
{
while true; do
echo ""
read choice
echo $choice
case $choice in 
      1) ./ping.sh 172.31.101;return;;
      2) ./nmap-ip-scan.sh;return;;
      3) ./meta-script.sh;return;;
      *)
                echo "Invalid entry." >&2
                exit 1
esac
done
}
menu
