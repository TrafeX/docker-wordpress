#!/bin/bash
set -e # terminate on errors

test "$(ls -A "/var/www/wp-content" 2>/dev/null)" || cp -r /usr/src/wordpress/wp-content /var/www/

exec "$@"
