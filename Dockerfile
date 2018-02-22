FROM alpine:3.7
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight WordPress container with Nginx 1.12 & PHP-FPM 7.1 based on Alpine Linux."

# Install packages from testing repo's
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl bash

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# wp-content volume
VOLUME /var/www/wp-content
WORKDIR /var/www/wp-content
RUN chown -R nobody.nobody /var/www

# WordPress
ENV WORDPRESS_VERSION 4.9.4
ENV WORDPRESS_SHA1 0e630bf940fd586b10e099cd9195b3e825fb194c

RUN mkdir -p /usr/src

# Upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C /usr/src/ \
	&& rm wordpress.tar.gz \
	&& chown -R nobody.nobody /usr/src/wordpress

# WP config
COPY wp-config.php /usr/src/wordpress
RUN chown nobody.nobody /usr/src/wordpress/wp-config.php && chmod 640 /usr/src/wordpress/wp-config.php

# Append WP secrets
COPY wp-secrets.php /usr/src/wordpress
RUN chown nobody.nobody /usr/src/wordpress/wp-secrets.php && chmod 640 /usr/src/wordpress/wp-secrets.php

# Entrypoint to copy wp-content
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
