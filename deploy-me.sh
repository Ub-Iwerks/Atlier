#!/bin/bash

cd /var/www/Atlier/ && git pull origin master
bundle install RAILS_ENV=production
