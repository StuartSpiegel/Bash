#Global shell variables
$my_tcp_port="5044"

sudo yum install logstash

#Create a config file for filebeat input to logstash
sudo vi /etc/logstash/conf.d/my_beats_input.conf

#Insert this configuration into the beats file
#input {
#  beats {
#    port => 5044
#  }
#}

#listening on TCP PORT (5044) use my_tcp_port

#add a logstash filter to parse incoming system logs
#filter {
#  if [fileset][module] == "system" {
#    if [fileset][name] == "auth" {
#      grok {
#        match => { "message" => ["%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} sshd(?:\[%{POSINT:[system][auth][pid]}\])?: %{DATA:[system][auth][ssh][event]} %{DATA:[system][auth][ssh][method]} for (invalid user )?%{DATA:[system][auth][user]} from %{IPORHOST:[system][auth][ssh][ip]} port %{NUMBER:[system][auth][ssh][port]} ssh2(: %{GREEDYDATA:[system][auth][ssh][signature]})?",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} sshd(?:\[%{POSINT:[system][auth][pid]}\])?: %{DATA:[system][auth][ssh][event]} user %{DATA:[system][auth][user]} from %{IPORHOST:[system][auth][ssh][ip]}",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} sshd(?:\[%{POSINT:[system][auth][pid]}\])?: Did not receive identification string from %{IPORHOST:[system][auth][ssh][dropped_ip]}",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} sudo(?:\[%{POSINT:[system][auth][pid]}\])?: \s*%{DATA:[system][auth][user]} :( %{DATA:[system][auth][sudo][error]} ;)? TTY=%{DATA:[system][auth][sudo][tty]} ; PWD=%{DATA:[system][auth][sudo][pwd]} ; USER=%{DATA:[system][auth][sudo][user]} ; COMMAND=%{GREEDYDATA:[system][auth][sudo][command]}",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} groupadd(?:\[%{POSINT:[system][auth][pid]}\])?: new group: name=%{DATA:system.auth.groupadd.name}, GID=%{NUMBER:system.auth.groupadd.gid}",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} useradd(?:\[%{POSINT:[system][auth][pid]}\])?: new user: name=%{DATA:[system][auth][user][add][name]}, UID=%{NUMBER:[system][auth][user][add][uid]}, GID=%{NUMBER:[system][auth][user][add][gid]}, home=%{DATA:[system][auth][user][add][home]}, shell=%{DATA:[system][auth][user][add][shell]}$",
#                  "%{SYSLOGTIMESTAMP:[system][auth][timestamp]} %{SYSLOGHOST:[system][auth][hostname]} %{DATA:[system][auth][program]}(?:\[%{POSINT:[system][auth][pid]}\])?: %{GREEDYMULTILINE:[system][auth][message]}"] }
#        pattern_definitions => {
#          "GREEDYMULTILINE"=> "(.|\n)*"
#        }
#        remove_field => "message"
#      }
#      date {
#        match => [ "[system][auth][timestamp]", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
#      }
#      geoip {
#        source => "[system][auth][ssh][ip]"
#        target => "[system][auth][ssh][geoip]"
#      }
#    }
#    else if [fileset][name] == "syslog" {
#      grok {
#        match => { "message" => ["%{SYSLOGTIMESTAMP:[system][syslog][timestamp]} %{SYSLOGHOST:[system][syslog][hostname]} %{DATA:[system][syslog][program]}(?:\[%{POSINT:[system][syslog][pid]}\])?: %{GREEDYMULTILINE:[system][syslog][message]}"] }
#        pattern_definitions => { "GREEDYMULTILINE" => "(.|\n)*" }
#        remove_field => "message"
#      }
#      date {
#        match => [ "[system][syslog][timestamp]", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
#      }
#    }
#  }
#}

#Configure logstash to store the beats data into elasticsearch running on localhost:9200
sudo vi /etc/logstash/conf.d/30-elasticsearch-output.conf

#output {
#  elasticsearch {
#    hosts => ["localhost:9200"]
#    manage_template => false
#    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
#  }
#}

# If you want to add filters for other applications that use the Filebeat input,
# be sure to name the files so they’re sorted between the input and the output configuration, meaning that the file names should begin with a two-digit number between 02 and 30.

#Test your logstash configuration
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t

#If tests pass
sudo systemctl start logstash
sudo systemctl enable logstash
