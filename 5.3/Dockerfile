FROM eugeneware/php-5.3:master

COPY docker-php-* /usr/local/bin/ 

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Install PHP extensions
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev zip unzip && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd
RUN docker-php-ext-install mysqli mbstring

RUN touch /usr/local/lib/conf.d/uploads.ini \
    && echo "upload_max_filesize = 250M;" >> /usr/local/lib/conf.d/uploads.ini

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]