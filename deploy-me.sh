#!/bin/bash

cd /var/www/Atlier/ && git pull
bundle install RAILS_ENV=production
