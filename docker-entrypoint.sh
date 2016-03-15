#!/bin/bash

mkdir -p /var/www/html/sites/default/files
chown -R www-data:www-data /var/www/html/sites/default/files

exec "$@"