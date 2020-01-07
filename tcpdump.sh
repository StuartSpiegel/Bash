#/bin/bash!
#Stuart Spiegel

#Include the relative file path to the target pcap file here
targetFile=$1

#Include the HOST definition here
hostName=$2

#Run tcpdump with options
#Disables HOST name and SERVICE name lookups filtering the data
tcpdump -nnr $targetFile

#Run tcpdump on a target HOST
tcpdump -r $targetFile $hostName

#How many packets were transmitted in this convo.
tcpdump -r $targetFile $hostName | wc  -l

#What IP Protocol was used?
tcpdump -vnn $targetFile $hostName

#What Server IP is providing DHCP
'udp port 68' | grep Reply

#Unique MAC Addresses in the REQUEST
tcpdump -r exercise-traffic.pcap 'udp port 68' | awk '/Request from/ { print $9
}' | sort -u  | wc -l

#Unique DHCP clients --> # MAC ADDRESSES on Network
tcpdump -r exercise-traffic.pcap 'udp port 68' | awk '/Request from/ { print $9 }' | sort -u  | wc -l
