
# WordPress Docker Container

Lightweight WordPress container with Nginx 1.28 & PHP-FPM 8.4 based on Alpine Linux.

_WordPress version currently installed:_ **6.9**

* Used in production for many sites, making it stable, tested and up-to-date
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)
* Works with Amazon Cloudfront or CloudFlare as SSL terminator and CDN
* Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
* Built on the lightweight Alpine Linux distribution
* Small Docker image size (+/-90MB)
* Uses PHP 8.4 for the best performance, low cpu usage & memory footprint
* Can safely be updated without losing data
* Fully configurable because wp-config.php uses the environment variables you can pass as an argument to the container

[![Docker Pulls](https://img.shields.io/docker/pulls/trafex/wordpress.svg)](https://hub.docker.com/r/trafex/wordpress/)
![nginx 1.28](https://img.shields.io/badge/nginx-1.28-brightgreen.svg)
![php 8.4](https://img.shields.io/badge/php-8.4-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## [![Trafex Consultancy](https://timdepater.com/logo/mini-logo.png)](https://timdepater.com?mtm_campaign=github)
I can help you with [Containerization, Kubernetes, Monitoring, Infrastructure as Code and other DevOps challenges](https://timdepater.com/?mtm_campaign=github).

## Usage

### Versioning

This image follows the **Debian versioning convention** for tagging: `<wordpress-version>-<container-revision>`

**Available tags:**
* `latest` - Latest stable release
* `<major>.<minor>.<patch>-<revision>` - Full version (e.g., `6.8.1-1`, `6.8.1-2`)
  * The first part (`6.8.1`) tracks the WordPress version included
  * The revision number (`-1`, `-2`) indicates container updates (security patches, dependency updates, configuration changes)
* `<major>.<minor>.<patch>` - Latest container revision for a WordPress version (e.g., `6.8.1` → `6.8.1-2`)
* `<major>.<minor>` - Latest patch and revision (e.g., `6.8` → `6.8.1-2`)
* `<major>` - Latest minor, patch and revision (e.g., `6` → `6.8.1-2`)

**For production use**, pin to a specific full version tag (e.g., `trafex/wordpress:6.8.1-1`) to ensure reproducible deployments and controlled updates.

### Running the Container

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
