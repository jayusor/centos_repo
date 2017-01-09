#!/bin/bash

reposync -r base -p /var/www/html/repos/
reposync -r epel -p /var/www/html/repos/
reposync -r updates -p /var/www/html/repos/
reposync -r extras -p /var/www/html/repos/
reposync -r dockerrepo -p /var/www/html/repos/