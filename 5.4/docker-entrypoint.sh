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
sed -i "s/\$password = ''/\$password = '$MYSQL_ENV_MYSQL_ROOT_PASSWORD'/g" /var/www/html/configuration.php
sed -i "s/\$db = ''/\$db = '$MYSQL_ENV_MYSQL_DATABASE'/g" /var/www/html/configuration.php
sed -i "s/\$dbprefix = 'jos_'/\$dbprefix = '$JOOMLA_MYSQL_PREFIX'/g" /var/www/html/configuration.php
sed -i "s/\$log_path = '/var/logs'/\$log_path = '/var/www/html/logs'/g" /var/www/html/configuration.php

if [ ! -d "/var/www/html/logs" ]; then
  mkdir /var/www/html/logs
fi

chown :www-data /var/www/html/.htaccess
chown :www-data /var/www/html/configuration.php
chown -R :www-data /var/www/html/logs
chown -R :www-data /var/www/html/tmp
chown -R :www-data /var/www/html/images
chown -R :www-data /var/www/html/administrator
chown -R :www-data /var/www/html/components
chown -R :www-data /var/www/html/language
chown -R :www-data /var/www/html/libraries
chown -R :www-data /var/www/html/media
chown -R :www-data /var/www/html/modules
chown -R :www-data /var/www/html/plugins
chown -R :www-data /var/www/html/cache

exec "$@"