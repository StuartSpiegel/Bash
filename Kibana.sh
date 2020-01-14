#/bin/bash
#

#unpack the archive
tar -xf kibana-7.3.1-linux-x86_64.tar.gz

#Call the kibana binary
./kibana-7.3.1-linux-x86_64/bin/kibana --host=0.0.0.0
