FROM php:5.6-fpm

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip
	
# new relic
RUN curl https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list'

RUN apt-get update && apt-get install -y newrelic-php5
ENV NR_INSTALL_SILENT true
ENV NR_INSTALL_PATH /usr/local/bin;
RUN newrelic-install install

# memcache & redis
RUN yes | pecl install redis memcache-3.0.8 \
	&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
	&& echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini
	
RUN apt-get update && apt-get -y install mysql-client

WORKDIR /root
# Install Drush 5 (legacy, can probably be removed)
RUN curl -L -O https://github.com/drush-ops/drush/archive/5.11.0.tar.gz \
	&& tar -xzf 5.11.0.tar.gz \
	&& chmod u+x /root/drush-5.11.0/drush \
	&& ln -s /root/drush-5.11.0/drush /usr/bin/drush5

# Install Drush 8
# If the .phar becomes unavailable this could be installed using Composer
# e.g. RUN composer global require drush/drush:"$DRUSH_VERSION" --prefer-dist
RUN curl -OL https://github.com/drush-ops/drush/releases/download/8.1.16/drush.phar \
	&& chmod +x drush.phar \
	&& mv drush.phar /usr/local/bin/drush

# drupal config for php
COPY drupal.ini /usr/local/etc/php/conf.d/

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
