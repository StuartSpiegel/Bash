#!/usr/bin/env bash
#Create the cluster --> Kubernetes cluster, single node ES cluster, Filebeat and Kibana

#Script Global Variables
#the name of the cluster, will also be assigned to the config file (.yaml)
#Default port for COMM is 9000
name="INSERT NAME OF CLUSTER"
elastic_version="INSERT VERSION NUMBER"
private_host="INSERT INTERNAL IP"
DockerFilePath="INSERT PATH TO DOCKER FILE"
DockerImageName="NAME OF DOCKER IMAGE"
COMM_PORT="INSERT COMMUNICATIONS PORT **PORT TO FORWARD FOR HTTP requests**"

#Use KIND to create the cluster
kind create cluster --config Configs/$name.yaml

#Unpack the Elastic Stack
tar -zxf elasticsearch-$elastic_version-linux-x86_64.tar.gz
tar -zxf kibana-$elastic_version-linux-x86_64.tar.gz
tar -zxf filebeat-$elastic_version-linux-x86_64.tar.gz

#Start Elasticsearch by calling binaries
./elasticsearch-$elastic_version/bin/elasticsearch -E node.name=node1 -E network.host="_site_" -E discovery.type="single-node"

#Start Kibana on PRIVATE HOST --> PrivateHost.sh
# ./PrivateHost

#Call the Kibana Binary
./kibana-7.3.2-linux-x86_64/bin/kibana --elasticsearch.hosts="http://{$private_host}:9200"

#Change to Directory of DockerFile Definition
cd $DockerFilePath

#Build the Docker Image from the provided Docker file
docker build --tag $DockerImageName

#Verify build completion
docker images

#Start the container
docker run -v /var/run/docker.sock:/var/run/docker.sock -itd --name $DockerImageName -p $COMM_PORT:80 -v /home/elastic/Configs/Docker/nginx.conf:/etc/nginx/nginx.conf $DockerImageName

#View the running container
docker ps

#Verify nginx container is handeling HTTP Requests
curl localhost:$COMM_PORT/server-status

#Create a service in Kubernetes
kubectl get nodes

#Create a configuration file to define a {nginx} deployment
mkdir ~/Configs/Kubernetes
cd ~/Configs/Kubernetes

#Edit the config file (Kubernetes-nginx.yaml)
vim Kubernetes-nginx.yaml

#apiVersion: apps/v1
#kind: Deployment
#metadata:
#  labels:
#    app: nginx
#  name: nginx
#spec:
#  selector:
#    matchLabels:
#      run: nginx
#  replicas: 2
#  template:
#    metadata:
#      labels:
#        run: nginx
#      annotations:
#        co.elastic.logs/module: nginx
#        co.elastic.logs/fileset.stdout: access
#        co.elastic.logs/fileset.stderr: error
#    spec:
#      containers:
#      - name: nginx
#        image: nginx
#        ports:
#        - containerPort: 80

#Run nginx deployment
kubectl apply -f Kubernetes-nginx.yaml
#Verify the deployment
kubectl get pods

kubectl expose deployment nginx --type=nodePort --name=nginx-service

#Forward a local port to service: forward -> forwards traffic to local port 8000
kubectl port-forward service/nginx-service 8000:80

#Verify the container nginx instance on Kubernetes Cluster
curl localhost:8000
