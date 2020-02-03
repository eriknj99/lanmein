# lanmein
An nmap wrapper for easy login into a dynamic host via a unique port.

## Motivation

I built LANmein for use on my colleges campus. It was frustrating typing in the same nmap command every time I needed access to my PC in my dorm.

LANmein is designed for a very particular use case. 
- You need to access your computer on your network through ssh.
- The computer has a dynamic IP address.
- You can change the computers ssh port to something unique.
- The computers IP address is restricted to a relativly small IP range. (Scannable in a reasonable amount of time)

If you meet the above criteria then LANmein is the tool for you!

## Usage
 
1. Change the first 3 lines of the script to match your use case.<br>
  - port: The ssh port of the host computer.<br>
  - scanRange: The IP range to scan looking for open ports. (nmap format E.G: 192.168.1-5.1-255)<br>
  - username: The username to log in with after the host is found.<br>
    (It is important that no other hosts have the same port open in the IP range)
    
2. Run
  ```sh ./lanmein.sh```
  
  - If the file 'last' does not exist or the host stored in 'last' is no longer up, an nmap scan will be initiated. The first IP address found by nmap with $port open will be connected to via ssh using the provided username. This new IP address will then replace the IP address stored in 'last'.
  
  - If the IP address stored 'last' is up and has $port open, it will be connected to via ssh.

  


