#!/bin/bash
#Stuart Spiegel
#-------------------------
#term=''
# cat / less <log> | grep <search term> | wc / col | lesscolor

#common bash procedures for formatting data Column-Page format
cat conn.log | column -t | less -S

#searh how many times a term appears in the data.
cat conn.log | column -t | grep $term | wc

#4 columns of split data using zeek
less conn.log | bro-cut id.orig_h protoservice orig_bytes | awk '$4 > 10000'

#Format Data and filter by color for a search term
less -S conn.log | column - t | grep $term | lesscolor

#Zeek Cut commands
cat conn.log | zeek-cut ts id_resp_p duration | lesscolor

cat conn.log | awk -F | sort -nr | less -S

cat conn.log | zeek-cut uid proto service | lesscolor

less conn.log | bro-cut id.orig_h duration | sort -nk2

cat conn.log | zeek-cut <field> <field> <field> | awk '$# > 100' | wc -l

cat conn.log | zeek-cut proto service duration | cut -f3 | sort | uniq | sort -n

#How many hosts originated bytes over 10,000
#28 hosts over 10,000 Bytes
cat conn.log | awk '$10 > 10000' | wc  -l

#format Zeek for Bytes over 10,000
cat conn.log | zeek-cut orig_bytes proto protoservice | awk '$1 > 10000' | cut -f 2,3 | uniq | sort -n | uniq

#grep -v == not
#To find number of unusual ports
cat conn.log | zeek-cut id.resp_p | grep -v "443" | wc -l

#How many are over non-standard http ports
cat conn.log | zeek-cut id.orig_h id.resp_h id_resp_p service | awk '$4 == "http" && $3!=80'

#Standard SSL communications (port 443)
cat conn.log | zeek-cut service | grep "ssl" | wc -l

#inverse search of ssl Traffic (SSL traffic not over the Standard Port)
cat conn.log | zeek-cut service | grep -v "ssl" | wc -l
