#Install and configure Kibana for production

sudo yum install Kibana

#Enable and start the service
sudo systemctl enable Kibana
sudo systemctl start Kibana

#Use the open ssl command to create admin Kibana user
echo "kibana-admin: 'openssl passwd -apr1'" | sudo tree -a /etc/htpasswd.users

#  create an Nginx server block file. As an example, we will refer to this file as example.com.conf, although you may find it helpful to give yours a more descriptive name. For instance,
# if you have a FQDN and DNS records set up for this server, you could name this file after your FQDN:
sudo vi /etc/nginx/conf.d/example.com.conf

#server {
#    listen 80;
#
#    server_name example.com www.example.com;
#
#    auth_basic "Restricted Access";
#    auth_basic_user_file /etc/nginx/htpasswd.users;
#
#    location / {
#        proxy_pass http://localhost:5601;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection 'upgrade';
#        proxy_set_header Host $host;
#        proxy_cache_bypass $http_upgrade;
#    }
#}

#Check configuration for syntax errors
sudo nginx -t

#restart the service
sudo systemctl restart nginx

#allow nginx to accsess the proxied service
sudo setsebool httpd_can_network_connect 1 -P

#Kibana is now accessible via your FQDN or the public IP address of your Elastic Stack server.
# You can check the Kibana server’s status page by navigating to the following address and entering your login credentials when prompted:

# http://your_server_ip/status
