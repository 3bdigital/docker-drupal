FROM drupal:7-fpm

# memcache & redis
RUN yes | pecl install redis memcache \
	&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
	&& echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]