port=22 #The ssh port of the host
scanRange="192.168.1-5.1-255" #The IP range to scan (nmap format)
username="user" #The username to login with

#Make sure last exists
touch last

#Get the contents of last
lastIP=$(cat last)
echo Last connected IP: $lastIP
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
