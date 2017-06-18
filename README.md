# WordPress Docker Container

Lightweight WordPress container with Nginx 1.12 & PHP-FPM 7.1 based on Alpine Linux.

_WordPress version currently installed:_ **4.8**

* Used in production for my own sites, making it stable, tested and up-to-date
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)
* Best to be used with Amazon Cloudfront as SSL terminator and CDN
* Built on the lightweight Alpine Linux distribution
* Small Docker image size (+/-45MB)
* Uses PHP 7.1 for better performance, lower cpu usage & memory footprint
* Can safely be updated without losing data
* Fully configurable because wp-config.php uses the environment variables you can pass as a argument to the container

[![Docker Pulls](https://img.shields.io/docker/pulls/trafex/wordpress.svg)](https://hub.docker.com/r/trafex/wordpress/) [![](https://images.microbadger.com/badges/image/trafex/wordpress.svg)](https://microbadger.com/images/trafex/wordpress "Get your own image badge on microbadger.com")


## Usage
See [docker-compose.yml](https://github.com/TrafeX/docker-wordpress/blob/master/docker-compose.yml) how to use it in your own environment.

    docker-compose up

Or

    docker run -d -p 80:80 -v /local/folder:/var/www/wp-content \
    -e "DB_HOST=db" \
    -e "DB_NAME=wordpress" \
    -e "DB_USER=wp" \
    -e "DB_PASSWORD=secret" \
    -e "FS_METHOD=direct" \
    trafex/wordpress


### Inspired by

* https://hub.docker.com/_/wordpress/
* https://codeable.io/wordpress-developers-intro-to-docker-part-two/
* https://github.com/TrafeX/docker-php-nginx/
* https://github.com/etopian/alpine-php-wordpress
