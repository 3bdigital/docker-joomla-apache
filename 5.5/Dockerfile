FROM php:5.5-apache

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Install PHP extensions
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev zip unzip libmcrypt-dev && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd
RUN docker-php-ext-install mysqli mbstring mcrypt

RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 250M;" >> /usr/local/etc/php/conf.d/uploads.ini

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

EXPOSE 443

COPY docker-entrypoint.sh /entrypoint.sh

COPY ssl/dev.3bweb.com.crt /etc/ssl/certs/ssl-cert-snakeoil.pem
COPY ssl/dev.3bweb.com.key /etc/ssl/private/ssl-cert-snakeoil.key

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]