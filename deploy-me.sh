#!/bin/bash

cd /var/www/Atlier/ && git pull origin master
cd /var/www/Atlier/ && bundle install --path vender/bundle
