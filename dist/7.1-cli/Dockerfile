FROM php:7.1-cli

MAINTAINER Piotr Zając <piotr.zajac@unixslayer.net>

RUN apt-get update -y && \
    apt-get install -y \
    ca-certificates \
    git \
    cron \
    wget \
    unzip \
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
  && pecl install mcrypt-1.0.0 \
  && apt-get clean

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  bcmath \
  gd \
  intl \
  mbstring \
  soap \
  xsl \
  zip \
  opcache

RUN docker-php-ext-enable mcrypt

ENV PHP_MEMORY_LIMIT="4G" \
PHP_PORT=9000 \
PHP_PM="dynamic" \
PHP_PM_MAX_CHILDREN=10 \
PHP_PM_START_SERVERS=4 \
PHP_PM_MIN_SPARE_SERVERS=2 \
PHP_PM_MAX_SPARE_SERVERS=6 \
COMPOSER_HOME="/var/www/.composer/"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chown -R www-data:www-data /var/www

COPY ./conf /conf/
COPY ./bin/init.sh /usr/local/bin/init.sh

RUN ["chmod", "+x", "/usr/local/bin/init.sh"]
RUN ["/usr/local/bin/init.sh"]

WORKDIR /var/www/html

CMD ["php-fpm"]
