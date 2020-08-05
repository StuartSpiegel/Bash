# The purpose of this script is to simplify and automate the install process for a multinode ES (ElasticSearch) Cluster
# You will want to install OPEN JDK (current version) on all nodes as well as ElasticSearch, use the ES rpm or manual wget, install kibana on the clusters master node
# Depending on the cloud hosting or local cluster setup you are using, I like to provision my nodes with CENTOS-7 OS with MEDIUM archietcure (4GB of System RAM)
# **Run this script on cluster master node** && MODIFY slightly for Data Nodes

#Script Globals
repo="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.1-x86_64.rpm"
version="7.8.1"
kibana="https://artifacts.elastic.co/downloads/kibana/kibana-7.8.1-x86_64.rpm"
#We want to define the ElasticSearch user since this can cause permission issues down the road
sudo useradd elasticsearch

#install the open JDK
sudo yum install -y elasticsearch java-1.8.0-openjdk

#install ElasticSearch
wget $repo
sudo rpm --install elasticsearch-$version-x86_64.rpm

#For master node install kibana as well
wget $kibana
sudo rpm --install -y kibana-$version-x86_64.rpm

#Create both Sym links for system-D
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service

#become the user we defined earlier in the script
sudo su - elasticseach
sudo cd /etc/elasticseach

# Configure the elasticseach.yml file : Example below
# MASTER NODE :
#
#node.name: master
#node.data: false
#network.host: [“localhost”, “<private IP of current node>”]
#discovery.seed_hosts: [“<private IP of master node>”, “<private IP of data1 node>”, “<private IP of data2 node>”]
#cluster.initial_master_nodes: [“<private IP of master node>”]
#
# DATA NODE :
#node.name: data1 (or data2)
#network.host: [“localhost”, “<private IP of current node>”]
#discovery.seed_hosts: [“<private IP of master node>”, “<private IP of data1 node>”, “<private IP of data2 node>”]
#cluster.initial_master_nodes: [“<private IP of master node>”]
#

#start elasticsearch on all Nodes
sudo systemctl start elasticseach.service
#start kibana instance on master nodes
sudo systemctl start kibana.service

#Ensure ES is configured correctly by CURLing the localhost
curl localhost:9200
# Ensure GREEN Health status
curl localhost:9200/_cluster/health?pretty=true
#############################################################################################################################################################################
# Lastly in most production settings you will not be running ES cluster or kibana from your local machine or machine(s). You will need to define a local SSH tunnel to view Kibana on localhost.
# ssh cloud_user@<public ip of master node> -L 5601:<private ip of master node>:5601 --> this may work but permissions can be annoying here, its also possibly you already have a port
#binding defined here.
#############################################################################################################################################################################
# Alternatively one can define a relation/mapping in Putty for the kibana application. Super handy feature
# Ensure Windows 10 firewall is on, open Putty
# 1. LEFT NAV - Sesssion
# 2. HOST NAME: user@<public_ip>
# 3. LEFT NAV: Connection-->SSH --> Tunnels
# 4. Source Port: 5601, Destination: 127.0.0.1:5601, Destionation: local, Destination: Auto
# 5. Click Add button to create the mapping
# 6. Left Nav- > Session --> Click Open --> authenticate with Putty and once authenticated leave terminal open preserving the tunnel!
# 7. Test the new tunnel --> open browser go to localhost:5601/app/kibana
##############################################################################################################################################################################
