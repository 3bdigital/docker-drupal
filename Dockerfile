FROM drupal:7-fpm

RUN apt-get update && apt-get install -y libz-dev libmemcached-dev

# memcached & redis
RUN yes | pecl install redis memcached \
	&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
	&& echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]