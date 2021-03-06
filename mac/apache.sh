#!/usr/bin/env bash

username=$1

if [ -z "$username" ]; then
    echo "Must provide username as 1st arguement."
    exit 1
fi

# Create directory for my projects.
if [[ ! -d /Users/$username/Sites ]]; then
  mkdir /Users/$username/Sites
fi

# Use my httpd.conf instead of the one that ships with macs.
sudo mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak
cd /etc/apache2/ && { sudo curl -fsSLO https://raw.githubusercontent.com/aczietlow/nix-dev-configuration/master/mac/conf/httpd.conf ; cd -; }
sudo sed -i '' "s/USERNAME/$username/g" /etc/apache2/httpd.conf
sudo apachectl restart

# @TODO Get virtual host added to direct to local work environment
