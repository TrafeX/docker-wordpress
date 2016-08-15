# Wordpress container

Wordpress container with Nginx 1.10 & PHP-FPM 7.0 based on Alpine Linux.

* Used in production for my own sites, making it stable and always up-to-date
* Optimized for 50 concurrent users
* Optimized for low resource usage (by using PHP-FPM's ondemand PM)
* Best to be used with Amazon Cloudfront as SSL terminator and CDN
* Uses PHP 7.0 for better performance, lower cpu & memory usage
* Can safely be updated without loosing data

[![Docker Pulls](https://img.shields.io/docker/pulls/trafex/wordpress.svg)](https://hub.docker.com/r/trafex/wordpress/)


## Usage
See docker-compose.yml how to use it in your own environment.

    docker-compose up

Or

    docker run -d trafex/wordpress -p 80:80 -v /local/folder:/var/www/wp-content -e "DB_HOST=db" -e "DB_NAME=wordpress" -e "DB_USER=wp" -e "DB_PASSWORD=secret"

### Inspired by

* https://hub.docker.com/_/wordpress/
* https://codeable.io/wordpress-developers-intro-to-docker-part-two/
* https://github.com/TrafeX/docker-php-nginx/
* https://github.com/etopian/alpine-php-wordpress
