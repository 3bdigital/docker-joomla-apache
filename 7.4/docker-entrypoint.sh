#!/bin/bash

# URL rewriting
if [ ! -f /var/www/html/.htaccess ]; then
    echo >&2 ".htaccess not found!"
    echo >&2 "creating..."
    
    cp /var/www/html/htaccess.txt /var/www/html/.htaccess
fi

# check for configuration file
if [ ! -f /var/www/html/configuration.php ]; then
    echo >&2 "configuration not found!"
    echo >&2 "creating..."
    
    cp /var/www/html/configuration-base.php /var/www/html/configuration.php
fi

sed -i "s/\$host = 'localhost'/\$host = 'mysql'/g" /var/www/html/configuration.php
sed -i "s/\$user = ''/\$user = 'root'/g" /var/www/html/configuration.php
sed -i "s/\$password = ''/\$password = '$MYSQL_ROOT_PASSWORD'/g" /var/www/html/configuration.php
sed -i "s/\$db = ''/\$db = '$MYSQL_JOOMLA_DATABASE'/g" /var/www/html/configuration.php
sed -i "s/\$dbprefix = 'jos_'/\$dbprefix = '$MYSQL_JOOMLA_PREFIX'/g" /var/www/html/configuration.php
sed -i "s/\$log_path = '\/logs'/\$log_path = 'logs'/g" /var/www/html/configuration.php
sed -i "s/\$log_path = '\/tmp'/\$log_path = 'tmp'/g" /var/www/html/configuration.php

if [ ! -d "/var/www/html/logs" ]; then
  mkdir /var/www/html/logs
fi

if [ ! -d "/var/www/html/tmp" ]; then
  mkdir /var/www/html/tmp
fi

chown :www-data /var/www/html/.htaccess
chown :www-data /var/www/html/configuration.php

exec "$@"