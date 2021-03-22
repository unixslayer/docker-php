ARG http_proxy=""
ARG https_proxy=""

FROM php:7.4-fpm

MAINTAINER Piotr Zając <piotr.zajac@unixslayer.pl>

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN apt update && apt install -y --no-install-recommends \
    bsdtar \
    ca-certificates \
    curl \
    git \
    imagemagick \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libonig-dev \
    libpng-dev \
    libxslt1-dev \
    libzip-dev \
    ssh \
    unzip \
    wget \
    zip

ADD ./bin/init.sh /usr/local/bin/init.sh
RUN ["chmod", "+x", "/usr/local/bin/init.sh"]
RUN ["/usr/local/bin/init.sh"]

RUN pecl install mcrypt-1.0.3 xdebug
RUN apt-get clean

RUN docker-php-ext-install \
  bcmath \
  gd \
  intl \
  mbstring \
  opcache \
  soap \
  xml \
  xsl \
  zip

RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-enable xdebug

ENV PHP_DATE_TIMEZONE="UTC" \
PHP_MEMORY_LIMIT="4G" \
PHP_PORT=9000 \
PHP_PM="dynamic" \
PHP_PM_MAX_CHILDREN=80 \
PHP_PM_START_SERVERS=5 \
PHP_PM_MIN_SPARE_SERVERS=5 \
PHP_PM_MAX_SPARE_SERVERS=35 \
PHP_PM_MAX_REQUESTS=0 \
PHP_DISPLAY_ERRORS="STDOUT" \
PHP_DISPLAY_STARTUP_ERRORS="On" \
PHP_MAX_INPUT_VARS=1000 \
PHP_POST_MAX_SIZE="512M" \
PHP_UPLOAD_MAX_FILESIZE="128M" \
PHP_OPCACHE_ENABLE=1 \
PHP_OPCACHE_ENABLE_CLI=1 \
PHP_OPCACHE_VALIDATE_TIMESTAMP=0 \
PHP_OPCACHE_MEMORY_CONSUMPTION="512MB" \
PHP_OPCACHE_MAX_ACCELERATED_FILES=60000 \
PHP_OPCACHE_CONSISTENCY_CHECK=0 \
PHP_XDEBUG_DEFAULT_ENABLE="On" \
PHP_XDEBUG_REMOTE_ENABLE="On" \
PHP_XDEBUG_REMOTE_AUTOSTART="Off" \
PHP_LISTEN_OWNER="www-data" \
PHP_LISTEN_GROUP="www-data" \
PHP_LISTEN_MODE="0777"

RUN chown -R www-data:www-data /var/www

COPY ./conf/php.ini /usr/local/etc/php/php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/

WORKDIR /var/www/html

EXPOSE $PHP_PORT

ENTRYPOINT /usr/local/sbin/php-fpm --nodaemonize --force-stderr
