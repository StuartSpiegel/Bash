#!/usr/bin/env bash

#Script Global Variables
DEFAULT_HOMEBREW_DIRECTORY="/usr/local/var/homebrew/linked/elasticsearch-full"
DEFAULT_ESCONFIG_DIRECTORY="/usr/local/etc/elasticsearch"
DEFAULT_ES_LOG_DIRECTORY="/usr/local/var/log/elasticsearch"

#Change Setting in Below Variable for the creation of the Elasticsearch2.yml
REPLICATION= "
#Create the Configuration file ElasticSearch2.yml for 2nd node
#This is the Default configuration file (ElasticSearch.yml.default)
# ======================== Elasticsearch Configuration =========================
#
# NOTE: Elasticsearch comes with reasonable defaults for most settings.
#       Before you set out to tweak and tune the configuration, make sure you
#       understand what are you trying to accomplish and the consequences.
#
# The primary way of configuring a node is via this file. This template lists
# the most important settings you may want to configure for a production cluster.
#
# Please consult the documentation for further information on configuration options:
# https://www.elastic.co/guide/en/elasticsearch/reference/index.html
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#
#cluster.name: elasticsearch_rspiegel
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
#node.name: node-2
#
# Add custom attributes to the node:
#
#node.attr.rack: r1
#
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
#path.data: /usr/local/var/lib/elasticsearch/
#
# Path to log files:
#
#path.logs: /usr/local/var/log/elasticsearch/
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
#bootstrap.memory_lock: true
#
# Make sure that the heap size is set to about half the memory available
# on the system and that the owner of the process is allowed to use this
# limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
#network.host: 192.168.0.1
#
# Set a custom port for HTTP:
#
#http.port: 9101
#
# For more information, consult the network module documentation.
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when this node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
#discovery.seed_hosts: ["host1", "host2"]
#
# Bootstrap the cluster using an initial set of master-eligible nodes:
#
#cluster.initial_master_nodes: ["node-1", "node-2"]
#
# For more information, consult the discovery and cluster formation module documentation.
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
#
#gateway.recover_after_nodes: 3
#
# For more information, consult the gateway module documentation.
#
# ---------------------------------- Various -----------------------------------
#
# Require explicit names when deleting indices:
#
#action.destructive_requires_name: true
"
############################################################################
cd $DEFAULT_ESCONFIG_DIRECTORY
cat > elasticsearch2.yml
$REPLICATION

#Call the ElasticSearch binaries with the specified .yml configuration file for each Node locally
elasticsearch -Des.config=$DEFAULT_HOMEBREW_DIRECTORY/config/elasticsearch.yml
elasticsearch -Des.config=$DEFAULT_HOMEBREW_DIRECTORY/config/elasticsearch2.yml

#Change back to the default install directory of Elasticsearch-full package -HOMEBREW-
cd $DEFAULT_HOMEBREW_DIRECTORY

#Elasticsearch-full : homebrew.mxcl.elasticsearch.plist

#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#  <dict>
#    <key>KeepAlive</key>
#    <true/>
#    <key>Label</key>
#    <string>homebrew.mxcl.elasticsearch</string>
#    <key>ProgramArguments</key>
#    <array>
#      <string>/usr/local/bin/elasticsearch</string>
#      <string>--config=/usr/local/Cellar/elasticsearch/1.2.0/config/elasticsearch.yml</string>
#    </array>
#    <key>EnvironmentVariables</key>
#    <dict>
#      <key>ES_JAVA_OPTS</key>
#      <string>-Xss200000</string>
#      <key>JAVA_HOME</key>
#      <string>/Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home</string>
#    </dict>
#    <key>RunAtLoad</key>
#    <true/>
#    <key>WorkingDirectory</key>
#    <string>/usr/local/var</string>
#    <key>StandardErrorPath</key>
#    <string>/dev/null</string>
#    <key>StandardOutPath</key>
##    <string>/dev/null</string>
  #</dict>
#</plist>

#Update the ElasticSearch plist to include the new elasticsearch2.yml in the OBJECTS ARRAY
cat > homebrew.mxcl.elasticsearch.plist
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>homebrew.mxcl.elasticsearch</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/elasticsearch</string>
      <string>--config=$DEFAULT_ESCONFIG_DIRECTORY/elasticsearch.yml</string>
      <string>--config=$DEFAULT_ESCONFIG_DIRECTORY/elasticsearch2.yml</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
      <key>ES_JAVA_OPTS</key>
      <string>-Xss200000</string>
      <key>JAVA_HOME</key>
      <string>/Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home</string>
    </dict>
    <key>RunAtLoad</key>
    <true/>
   <key>WorkingDirectory</key>
    <string>/usr/local/var</string>
    <key>StandardErrorPath</key>
    <string>/dev/null</string>
   <key>StandardOutPath</key>
    <string>/dev/null</string>
  </dict>
</plist>

#Change to the default log directory of elasticsearch-full
cd $DEFAULT_ES_LOG_DIRECTORY
ls -la
