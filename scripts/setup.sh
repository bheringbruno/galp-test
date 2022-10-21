#!/bin/bash
set -e

# Install necessary dependencies
sudo apt-get update && sudo apt-get install apache2 ssh -y

# Installing SSH key
sudo cp /tmp/*.pub /home/ubuntu/.ssh/authorized_keys
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys
sudo chown -R ubuntu /home/ubuntu/.ssh
sudo touch /var/www/html/index.html
sudo chown ubuntu:www-data /var/www/html/index.html
sudo chmod 765 /var/www/html/index.html
