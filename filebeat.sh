#/bin/bash
#Unpack and Deploy Filebeat

#declare global script variables
version="ENTER VERSION"

#unpack the archive
tar -xf filebeat-7.3.1-linux-x86_64.tar.gz

#Edit the filebeat config (.yml)
# -> sudo vim ~/datasets/filebeat.yml

#Call the file beat binaries
./filebeat-7.3.1-linux-x86_64/filebeat -c datasets/filebeat.yml

#Option 2: Call with version
./filebeat-$version-linux-x86_64/filebeat -c datasets/filebeat.yml
