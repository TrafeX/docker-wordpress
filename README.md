# Wordpress container

Wordpress container with Nginx 1.10 & PHP-FPM 7.0 based on Alpine Linux.

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
