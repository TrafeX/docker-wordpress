
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
* Includes redis server and redis-cache plugin
* Includes nginx reverse proxy server to use Wordpress securely via HTTPS
* Includes a few php.ini optimizations. You can always load your own php.ini for further modifications.



![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)


## Usage
See [docker-compose.yml] how to use it in your own environment.

The easiest way to run this is using Portainer > New Stack > From Repository, and point to this Repo.

Currently this is not published to Docker.io so you need to either download the files and point Docker Compose to them, or point to the repository using Portainer.

Notes:

Everything works out of the box with Wordpress available on HTTP port 8123 for the 1 minute install.

Additional recommended steps:

- Go to Wordpress plugins > enable Redis Cache plugin. Then go to Redis Cache settings and enable it. It should be automatic.
- Go to nginx proxy manager on port 81, set up SSL, and set up a host redirection to enable your domain to point to Wordpress. This will enable you to use HTTPS on your site.
- Warning: do not disable the SQLite plugin as it is your only database. If you do so accidentally, add db.php back to wp-content folder (you can find the db.copy file in the plugin's directory and copy it back to /wp-content/, renamed to db.php)

  
### WP-CLI

This image includes [wp-cli](https://wp-cli.org/) which can be used like this:

    docker exec <your container name> /usr/local/bin/wp --path=/usr/src/wordpress <your command>


## Inspired by

* https://hub.docker.com/_/wordpress/
* https://codeable.io/wordpress-developers-intro-to-docker-part-two/
* https://github.com/TrafeX/docker-php-nginx/
* https://github.com/etopian/alpine-php-wordpress
* https://github.com/WordPress/sqlite-database-integration
