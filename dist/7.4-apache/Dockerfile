ARG http_proxy=""
ARG https_proxy=""

FROM php:7.4-apache

MAINTAINER Piotr Zając <piotr.zajac@unixslayer.pl>

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN pear config-set http_proxy ${http_proxy}
RUN export http_proxy=${http_proxy} && export https_proxy=${https_proxy}

RUN apt-get update -y && \
    apt-get install -y \
    ca-certificates \
    git \
    cron \
    wget \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libxslt1-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    libjpeg-dev \
    libonig-dev \
    libzip-dev

RUN pecl install mcrypt
RUN apt-get clean

RUN docker-php-ext-configure gd

RUN docker-php-ext-install \
  bcmath \
  gd \
  intl \
  mbstring \
  soap \
  xsl \
  zip \
  xml \
  opcache

RUN pecl install xdebug

RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-enable xdebug

ENV PHP_MEMORY_LIMIT="4G" \
SERVER_NAME="php.local" \
SERVER_ADMIN="webmaster@local" \
DOCUMENT_ROOT="/var/www/html" \
SERVER_SERVICE="php" \
SERVER_ENVIRONMENT="dev" \
PHP_DISPLAY_ERRORS="STDOUT" \
PHP_DISPLAY_STARTUP_ERRORS="On" \
PHP_MAX_INPUT_VARS=1000 \
PHP_MEMORY_LIMIT="4G" \
PHP_POST_MAX_SIZE="512M" \
PHP_OPCACHE_ENABLE=1 \
PHP_OPCACHE_ENABLE_CLI=1 \
PHP_OPCACHE_VALIDATE_TIMESTAMP=0 \
PHP_OPCACHE_MEMORY_CONSUMPTION="512MB" \
PHP_OPCACHE_MAX_ACCELERATED_FILES=60000 \
PHP_OPCACHE_CONSISTENCY_CHECK=0 \
PHP_XDEBUG_DEFAULT_ENABLE="On" \
PHP_XDEBUG_REMOTE_ENABLE="On" \
PHP_XDEBUG_REMOTE_AUTOSTART="Off" \
http_proxy=${http_proxy} \
https_proxy=${https_proxy}

RUN chown -R www-data:www-data /var/www

ADD ./conf/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./conf/conf-enabled/*                 /etc/apache2/conf-enabled/
ADD ./conf/php.ini /usr/local/etc/php/php.ini
ADD ./bin/init.sh /usr/local/bin/init.sh
RUN ["chmod", "+x", "/usr/local/bin/init.sh"]
RUN ["/usr/local/bin/init.sh"]

WORKDIR /var/www/html

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
