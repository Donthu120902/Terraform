#!/bin/bash

sudo yum install -y httpd
sudo systemctl start httpd
sudo systemcl enable httpd
sudo echo "This is the Teraform provisioner automation" >> /var/www/html/index.html
sudo systemctl restart httpd
