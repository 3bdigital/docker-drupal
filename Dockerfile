FROM drupal:7-fpm

# memcache & redis
RUN yes | pecl install redis memcache-3.0.8 \
	&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
	&& echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini
	
RUN apt-get update && apt-get -y install mysql-client

WORKDIR /root
RUN curl -L -O https://github.com/drush-ops/drush/archive/5.11.0.tar.gz \
	&& tar -xzf 5.11.0.tar.gz \
	&& chmod u+x /root/drush-5.11.0/drush \
	&& ln -s /root/drush-5.11.0/drush /usr/bin/drush5

RUN curl -O http://files.drush.org/drush.phar \
	&& chmod +x drush.phar \
	&& mv drush.phar /usr/local/bin/drush

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]