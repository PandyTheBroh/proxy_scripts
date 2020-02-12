#!/bin/bash

#Proxy Config

AUTO_URL=<AUTO_CONFIG_URL_PROXY_SERVER>
PROXY_USER=<YOUR_NETWORK_ACCOUNT_USER>
PROXY_PASS=<YOUR_NETWORK_ACCOUNT_PASS>
PROXY_PROTOCOL=<HTTP://_OR_HTTPS://>
PROXY_SERVER=<URL_PROXY_SERVER>
PROXY_PORT=<PORT_PROXY_SERVER>

#System-wide proxy
declare -x {http,https,ftp,all}_proxy="$PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER:$PROXY_PORT"
declare -x no_proxy='localhost,127.0.0.1,10.{1..255}.{1..255}.{1..255}'

#etc/environment: ln -s ~/.local/share/proxy/environment /etc/environment
sed -i 's/#http/http/g' ~/.local/share/proxy/environment
sed -i 's/#ftp/ftp/g' ~/.local/share/proxy/environment
sed -i 's/#all/all/g' ~/.local/share/proxy/environment
netplan apply


#Gnome
gsettings set org.gnome.system.proxy autoconfig-url 'http://esscrprx1/pac_bluecoat.pac'
gsettings set org.gnome.system.proxy mode 'manual' 
gsettings set org.gnome.system.proxy.http enabled true

gsettings set org.gnome.system.proxy.http host "'$PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER'";
gsettings set org.gnome.system.proxy.http port $PROXY_PORT;

gsettings set org.gnome.system.proxy.https host "'$PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER'";
gsettings set org.gnome.system.proxy.https port $PROXY_PORT;

gsettings set org.gnome.system.proxy.ftp host "'$PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER'";
gsettings set org.gnome.system.proxy.ftp port $PROXY_PORT;

gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '10.0.0.0/8']";

#Git
git config --global http.proxy $PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER:$PROXY_PORT
git config --global https.proxy $PROXY_PROTOCOL$PROXY_USER:$PROXY_PASS@$PROXY_SERVER:$PROXY_PORT
git config --global http.proxyAuthMethod 'basic'

#Docker: ln -s ~/.local/share/docker/docker.service /etc/systemd/system/docker.service.d/http-proxy.conf
sed -i 's/#Environment="HTTP_PROXY/Environment="HTTP_PROXY/g' ~/.local/share/docker/docker.service
sed -i 's/#Environment="HTTPS_PROXY/Environment="HTTPS_PROXY/g' ~/.local/share/docker/docker.service
systemctl daemon-reload
systemctl restart docker

#Apt: ln -s ~/.local/share/apt/02proxy /etc/apt/apt.conf.d/02proxy
sed -i 's/#Acquire/Acquire/g' ~/.local/share/apt/02proxy
