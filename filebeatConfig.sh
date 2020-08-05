sudo yum install filebeat

#open the filebeat config file
sudo vi /etc/filebeat/filebeat.yml

# Filebeat supports numerous outputs, but you’ll usually only send events directly to Elasticsearch or to Logstash for additional processing. In this tutorial, we’ll use Logstash to perform additional processing on the data collected by Filebeat. Filebeat will not need to send any data directly to Elasticsearch, so let’s disable that output.
# To do so, find the output.elasticsearch section and comment out the following lines by preceding them with a #:
#
#...
#output.elasticsearch:
  # Array of hosts to connect to.
  #hosts: ["localhost:9200"]
#...

#Then, configure the output.logstash section. Uncomment the lines output.logstash: and hosts: ["localhost:5044"] by removing the
#. This will configure Filebeat to connect to Logstash on your Elastic Stack server at port 5044, the port for which we specified a Logstash input earlier:

#output.logstash:
  # The Logstash hosts
#  hosts: ["localhost:5044"]

#enable the filebeat module on the system
sudo filebeat modules enable system
sudo filebeat modules list

# load in our index template from ES.
sudo filebeat setup --template -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'
sudo filebeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['localhost:9200'] -E setup.kibana.host=localhost:5601

#start the service with our initial configuration
sudo systemctl start filebeat
sudo systemctl enable filebeat

#Query the entire filebeat index to test
curl -X GET 'http://localhost:9200/filebeat-*/_search?pretty'
