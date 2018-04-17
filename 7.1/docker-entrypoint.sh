#!/bin/bash

: ${DRUPAL_SITE_ROOT=/var/www/html}

mkdir -p "$DRUPAL_SITE_ROOT/sites/default/files"
chown -R www-data:www-data "$DRUPAL_SITE_ROOT/sites/default/files"

exec "$@"