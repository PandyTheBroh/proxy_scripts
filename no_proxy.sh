#!/bin/bash

#Unset system-wide proxy
declare -x {http,https,ftp}_proxy
declare -x no_proxy

unset http_proxy
unset https_proxy
unset all_proxy
unset ftp_proxy

#etc/environment: ln -s ~/.local/share/proxy/environment /etc/environment
sed -i 's/http/#http/g' ~/.local/share/proxy/environment
sed -i 's/ftp/#ftp/g' ~/.local/share/proxy/environment
sed -i 's/all/#all/g' ~/.local/share/proxy/environment
netplan apply

#Gnome
gsettings set org.gnome.system.proxy mode 'none'

#Git
git config --global --remove-section http
git config --global --remove-section https

#Docker
sed -i 's/Environment="HTTP_PROXY/#Environment="HTTP_PROXY/g' ~/.local/share/docker/docker.service
sed -i 's/Environment="HTTPS_PROXY/#Environment="HTTPS_PROXY/g' ~/.local/share/docker/docker.service
systemctl daemon-reload
systemctl restart docker

#Apt
sed -i 's/Acquire/#Acquire/g' ~/.local/share/apt/02proxy
