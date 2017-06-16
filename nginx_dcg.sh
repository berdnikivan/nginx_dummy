#!/bin/bash
conf_path="/etc/nginx/sites-available/002_default.conf"
conf_ln="/etc/nginx/sites-enabled/002_default.conf"
echo "server {" > $conf_path
ips=$(ip -f inet addr show eth0 | awk '{ print $2}'| grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
for ip in $ips
	do
		echo "    listen $ip:80 default_server;" >> $conf_path
done
echo "    server_name _;
    return 444;
    }
" >> $conf_path
ln -sf $conf_path $conf_ln