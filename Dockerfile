FROM php:7.2-fpm-alpine

RUN apk add --update  \
    imagemagick \
    imagemagick-dev \
    graphicsmagick \
    ghostscript \
    python \
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
    && docker-php-ext-configure intl \
    # && printf "\n" | pecl install mcrypt-1.0.1 \
    # && docker-php-ext-enable mcrypt \
    && CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    pecl install imagick-3.4.3 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/lib/ \
    --with-png-dir=/usr/lib/ \
    --with-jpeg-dir=/usr/lib/ \
    && docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    exif \
    intl \
    gettext \
    mysqli \
    hash \
    pcntl \
    pdo_mysql \
    soap \
    sockets \
    tokenizer \
    sysvmsg \
    sysvsem \
    sysvshm \
    shmop \
    xsl \
    zip \
    gd \
    opcache


# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN composer global require hirak/prestissimo
