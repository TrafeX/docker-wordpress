FROM alpine:3.18
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight WordPress container with Nginx 1.24 & PHP-FPM 8.1 based on Alpine Linux."

# Install packages
RUN apk --no-cache add \
  php81 \
  php81-fpm \
  php81-mysqli \
  php81-json \
  php81-openssl \
  php81-curl \
  php81-zlib \
  php81-xml \
  php81-phar \
  php81-intl \
  php81-dom \
  php81-xmlreader \
  php81-xmlwriter \
  php81-exif \
  php81-fileinfo \
  php81-sodium \
  php81-gd \
  php81-simplexml \
  php81-ctype \
  php81-mbstring \
  php81-zip \
  php81-opcache \
  php81-iconv \
  php81-pecl-imagick \
  nginx \
  supervisor \
  curl \
  bash \
  less

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php81/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# wp-content volume
VOLUME /var/www/wp-content
WORKDIR /var/www/wp-content
RUN chown -R nobody.nobody /var/www

# WordPress
ENV WORDPRESS_VERSION 6.2.2
ENV WORDPRESS_SHA1 a355d1b975405a391c4a78f988d656b375683fb2

RUN mkdir -p /usr/src

# Upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C /usr/src/ \
	&& rm wordpress.tar.gz \    
	&& chown -R nobody.nobody /usr/src/wordpress

# Add WP CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

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

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1/wp-login.php
