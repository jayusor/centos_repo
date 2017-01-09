#!/bin/bash

## CREAR REPOS
createrepo /var/www/html/repos/base
createrepo /var/www/html/repos/updates
createrepo /var/www/html/repos/extras
createrepo /var/www/html/repos/epel
createrepo /var/www/html/repos/dockerrepo