
# WordPress Docker Container

Lightweight WordPress container with Nginx 1.26 & PHP-FPM 8.4 based on Alpine Linux. Uses SQLite for database storage for speed and portability. No separate MySQL or MariaDB container necessary. Also includes a redis container for a fast Persistent Object Cache, and nginx-reverse-proxy to setup HTTPS access to Wordpress

_WordPress version currently installed:_ **6.7.2**

* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)
* Works with Amazon Cloudfront or CloudFlare as SSL terminator and CDN
* Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
* Built on the lightweight Alpine Linux distribution
* Small Docker image size (+/-90MB)
* Uses PHP 8.4 for the best performance, low cpu usage & memory footprint
* Can safely be updated without losing data
* Fully configurable because wp-config.php uses the environment variables you can pass as an argument to the container

![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)


## Usage
See [docker-compose.yml] how to use it in your own environment.

    docker-compose up

Or

    docker run -d -p 80:80 -v /local/folder:/var/www/wp-content \
    -e "DB_HOST=db" \
    -e "DB_NAME=wordpress" \
    -e "DB_USER=wp" \
    -e "DB_PASSWORD=secret" \
    -e "FS_METHOD=direct" \
    trafex/wordpress

### WP-CLI

This image includes [wp-cli](https://wp-cli.org/) which can be used like this:

    docker exec <your container name> /usr/local/bin/wp --path=/usr/src/wordpress <your command>


## Inspired by

* https://hub.docker.com/_/wordpress/
* https://codeable.io/wordpress-developers-intro-to-docker-part-two/
* https://github.com/TrafeX/docker-php-nginx/
* https://github.com/etopian/alpine-php-wordpress
* https://github.com/WordPress/sqlite-database-integration
