#/bin/bash
#Stuart Spiegel

#Script for deploying suricata with OPTIONS:
#1: use the deafult configuration
#2: Point to the paket capture directory
suricata -c /etc/suricata/suricata.yaml -S ./test.rules -r ~/pcap/2017-10-21-traffic-analysis-exercise.pcap -l ~/suricata/alerts/


#Deploy suricata with options
#1: use the default configuration
#2: RunMODE single 
suricata --runmode=single -c /etc/suricata/suricata.yaml -S ./http3.rules -r ~/pcap/2017-10-21-traffic-analysis-exercise.pcap -l ~/suricata/alerts/
