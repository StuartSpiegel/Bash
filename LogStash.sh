#/bin/bash
#Unpack and Deploy LogStash pipeline

#declare global script variables
version="ENTER VERSION"

CONF_PATH="PATH TO CONFIG FILE"

#unpack archive and deploy LogStash pipeline
tar -xf logstash-7.3.1.tar.gz

#unpack logStash with options
tar -xf logstash-$version.tar.gz

#call the Logstash binaries
./logstash-7.3.1/bin/logstash -f datasets/blogs_sql.conf

#Option 2: Call Logstash with modified version
./logstash-$version/bin/logstash -f datasets/blogs_sql.conf

#Options 3: Deploy logstash: WILDCARD -> Pointer to config (.conf), VERSION
./logstash-$version/bin/logstash -f $CONF_PATH
