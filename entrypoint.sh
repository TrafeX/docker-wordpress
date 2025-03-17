#!/bin/bash

# terminate on errors
set -e

# Check if volume is empty
if [ ! "$(ls -A "/var/www/wp-content" 2>/dev/null)" ]; then
    echo 'Setting up wp-content volume'
    # Copy wp-content from Wordpress src to volume
    cp -r /usr/src/wordpress/wp-content /var/www/
    chown -R nobody:nobody /var/www
fi
if ! [ -f "/var/www/wp-content/wp-cli.yml" ]; then
    echo 'Setting up wp-cli.yml'
    # Copy wp-cli.yml from Wordpress src to volume
    cp /usr/src/wordpress/wp-cli.yml /var/www/wp-content/
    chown nobody:nobody /var/www/wp-content/wp-cli.yml
fi
# Check if wp-secrets.php exists
if ! [ -f "/var/www/wp-content/wp-secrets.php" ]; then
    echo '<?php' > /var/www/wp-content/wp-secrets.php
    # Check that secrets environment variables are not set
    if [ ! $AUTH_KEY ] \
    && [ ! $SECURE_AUTH_KEY ] \
    && [ ! $LOGGED_IN_KEY ] \
    && [ ! $NONCE_KEY ] \
    && [ ! $AUTH_SALT ] \
    && [ ! $SECURE_AUTH_SALT ] \
    && [ ! $LOGGED_IN_SALT ] \
    && [ ! $NONCE_SALT ]; then
        echo "Generating wp-secrets.php"
        # Generate secrets
        curl -f https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/wp-content/wp-secrets.php
    fi
fi
exec "$@"
