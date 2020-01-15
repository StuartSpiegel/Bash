#/bin/bash
#Unpack and Deploy Elastic in the background or foreground

#variable for version call
version="ENTER VERSION"

#Unpack the archive and extract repo
tar -xf elasticsearch-7.3.1-linux-x86_64.tar.gz

#Call Elastic binaries
./elasticsearch-7.3.1/bin/elasticsearch

#Call Elastic binaries with modified version
# -> ./elasticsearch-$version/bin/elasticsearch

#check Elastic Deployment: query basic Node and Cluster information
curl -X GET "http://localhost:9200/"

#Configure Elastic
# -> sudo vim elasticsearch-7.3.1/config/elasticsearch.yml

#Option 2 Configure Elastic
# -> sudo vim elasticsearch-$version/config/elasticsearch.yml

#Start Elastic in the Foreground (http: HOST) configuration
# -> ./elasticsearch-7.3.1/bin/elasticsearch -E node.name=node1 -E http.host="localhost", "server1"

#Start Elastic in the Foreground with VERSION option
# -> ./elasticsearch-$version/bin/elasticsearch -E node.name=node1 -E http.host="localhost", "server1"
