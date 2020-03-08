#!/bin/bash
port=6525 #The ssh port of the host
scanRange="10.2-3.2-3.2-255" #The IP range to scan (nmap format)
username="erik" #The username to login with

#Make sure last exists
touch last

#Check to see if an IP address was given manually, if not use the last connected IP.
if [ $# -eq 2 ]; then
  if [ $1 == "-m" ]; then
      lastIP=$2
      echo -e "Given IP: " $lastIP
  fi
else
  lastIP=$(cat last)
  echo Last connected IP: $lastIP
fi

echo -e "Checking connection...\c"

#Check if host is up on $lastIP:$port
if [[ $(nmap -p "$port" "$lastIP" 2> /dev/null ) == *open* ]]; then
	#If host is up connect
	echo Success!
	ip=$lastIP
else
	#If not rescan the IP range
	echo -e "Fail!\nScanning for new IP..."
	ip=$(nmap -np $port --open $scanRange -oG - | awk '/Up$/{print $2}') 
fi

#Rewrite $ip to last to ensure it is always up to date
echo $ip > last

#Connect
echo Attempting login $username@$ip...
ssh -p $port $username@$ip -XC
