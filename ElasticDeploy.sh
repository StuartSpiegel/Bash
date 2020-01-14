#/bin/bash
#Script for deploying Elastic Node with Options
#Cluster_NAME

#extract the elasticsearch archive (tarball)
tar -xf elasticsearch-7.3.1-linux-x86_64.tar.gz

#Start elastic search by calling the binary
./elasticsearch-7.3.1/bin/elasticsearch

#Request Host information
curl -X GET "http://localhost:9200/"

#---------------------------------------------------------------#
#Alternate DEPLOY: NON-DEFAULTS - EDIT the yml file for config
vim elasticsearch-7.3.1/config/elasticsearch.yml

#Call the Elastic binary
./elasticsearch-7.3.1/bin/elasticsearch

#Call the elastic binary with Param passed:  HOSTNAME and SSH 
./elasticsearch-7.3.1/bin/elasticsearch -E node.name=node1 -E http.host="localhost","server1"
