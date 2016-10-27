#!/bin/bash

# terminate on errors
set -e

DB_PORT=${DB_PORT:-3306}
# wait for db to be ready
while ! nc -z -v -w1 ${DB_HOST} ${DB_PORT} ; do echo "Waiting for ${DB_HOST}:${DB_PORT}" && sleep 5 ; done

# Check if volume is empty
if [ ! "$(ls -A "/var/www/wp-content" 2>/dev/null)" ]; then
    echo 'Setting up wp-content volume'
    # Copy wp-content from Wordpress src to volume
    cp -r /usr/src/wordpress/wp-content /var/www/
    chown -R nobody.nobody /var/www

    # Generate secrets
    curl -f https://api.wordpress.org/secret-key/1.1/salt/ >> /usr/src/wordpress/wp-secrets.php
fi
exec "$@"
