#Deploy ElasticSearch in a non-local environment (Docker Container, AWS, Azure)
HOSTNAME="Global Host variable goes here"
USER="USER"

#Create a living ssh connection on port 22.
ssh $USER@$HOSTNAME -y

#Privledges Adjustment if necessary
# -> sudo -l -> Sudoers list ->
# -> sudo -R elasticsearch:elasticsearch /etc/elasticsearch

#Create the elastic USER
sudo useradd elastic

#Make the updates to configuration files
sudo vim /etc/security/limits.conf

sudo vim /etc/sysctl.conf # vm.max_map_count=262144

#update the sysctl daemon with the new writes
sudo sysctl -p

#Become the Elastic USER
sudo su - elastic

#Get the elastic search paclage
curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.1-linux-x86_64.tar.gz

tar -xzvf elasticsearch-7.2.1-linux-x86_64.tar.gz

rm -f elasticsearch-7.2.1-linux-x86_64.tar.gz
mv elasticsearch-7.2.1/ elasticsearch
ls -la

#System.d Administration of ES
#sudo systemctl enable elasticsearch.service
#sudo Systemctl start elasticsearch.service
#systemctl daemon-reload
#systemctl restart elasticsearch

#sudo systemctl enable Kibana.service
#sudo systemctl start Kibana.service
#systemctl daemon-reload
#systemctl restart Kibana

systemctl list-units
