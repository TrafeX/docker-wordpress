
# WordPress Docker Container

Lightweight WordPress container with Nginx 1.22 & PHP-FPM 8.1 based on Alpine Linux.

_WordPress version currently installed:_ **6.2.2**

* Used in production for many sites, making it stable, tested and up-to-date
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)
* Works with Amazon Cloudfront or CloudFlare as SSL terminator and CDN
* Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
* Built on the lightweight Alpine Linux distribution
* Small Docker image size (+/-90MB)
* Uses PHP 8.1 for the best performance, low cpu usage & memory footprint
* Can safely be updated without losing data
* Fully configurable because wp-config.php uses the environment variables you can pass as an argument to the container

[![Docker Pulls](https://img.shields.io/docker/pulls/trafex/wordpress.svg)](https://hub.docker.com/r/trafex/wordpress/)
![nginx 1.24](https://img.shields.io/badge/nginx-1.24-brightgreen.svg)
![php 8.1](https://img.shields.io/badge/php-8.0-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## [![Trafex Consultancy](https://timdepater.com/logo/mini-logo.png)](https://timdepater.com?mtm_campaign=github)
I can help you with [Containerization, Kubernetes, Monitoring, Infrastructure as Code and other DevOps challenges](https://timdepater.com/?mtm_campaign=github).

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

### WP-CLI

This image includes [wp-cli](https://wp-cli.org/) which can be used like this:

    docker exec <your container name> /usr/local/bin/wp --path=/usr/src/wordpress <your command>


## Inspired by

* https://hub.docker.com/_/wordpress/
* https://codeable.io/wordpress-developers-intro-to-docker-part-two/
* https://github.com/TrafeX/docker-php-nginx/
* https://github.com/etopian/alpine-php-wordpress
