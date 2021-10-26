FROM php:7.4-fpm-alpine3.13

RUN apk add --update  \
    imagemagick \
    imagemagick-dev \
    graphicsmagick \
    ghostscript \
    python2 \
    unzip \
    # Libraries
    libldap \
    libxslt \
    zlib \
    libpng \
    # libmcrypt \
    libjpeg-turbo-dev \
    freetype-dev \
    # Dev and headers
    bzip2-dev \
    gettext-dev \
    icu-dev \
    libldap \
    ldb-dev \
    # libmcrypt-dev \
    libxml2-dev \
    libxslt-dev \
    zlib-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-configure intl \
    # && printf "\n" | pecl install mcrypt-1.0.1 \
    # && docker-php-ext-enable mcrypt \
    && CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    pecl install imagick-3.4.3 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    exif \
    intl \
    gettext \
    mysqli \
    pcntl \
    pdo_mysql \
    soap \
    sockets \
    tokenizer \
    sysvmsg \
    sysvsem \
    sysvshm \
    shmop \
    zip \
    gd \
    opcache

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --2 \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# RUN composer global require hirak/prestissimo
