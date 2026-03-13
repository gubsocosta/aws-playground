# ============================
# Build Stage
# ============================
FROM php:8.5-cli-alpine AS builder

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --no-cache \
    g++ \
    gcc \
    make \
    linux-headers \
    autoconf \
    libpng \
    libjpeg-turbo \
    freetype \
    imagemagick \
    imagemagick-libs \
    libgomp \
    openldap \
    snappy \
    postgresql-libs \
    lz4-libs \
    libzip \
    libmemcached-libs \
    zlib \
    libstdc++ \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    imagemagick-dev \
    openldap-dev \
    snappy-dev \
    postgresql-dev \
    lz4-dev \
    libzip-dev \
    libmemcached-dev \
    zlib-dev

# Install PHP extensions
RUN curl -sSLf -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
        bcmath \
        igbinary \
        imagick \
        ldap \
        memcached \
        mongodb \
        msgpack \
        pcov \
        pdo_mysql \
        pdo_pgsql \
        redis \
        soap \
        xdebug \
        zip

RUN php -m && echo "=== Build stage extensions OK ==="

# ============================
# Production Stage
# ============================
FROM php:8.5-cli-alpine AS production

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    nodejs \
    npm \
    openssl \
    libpng \
    libjpeg-turbo \
    freetype \
    imagemagick \
    imagemagick-libs \
    libgomp \
    openldap \
    snappy \
    postgresql-libs \
    lz4-libs \
    libzip \
    libmemcached-libs \
    zlib \
    libstdc++ && \
    rm -rf /var/cache/apk/*

# Copy PHP extensions from builder
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Copy composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN php -m && echo "=== Production stage extensions OK ==="

WORKDIR /var/www

# Copy existing application directory permissions
COPY --chown=www-data:www-data ./laravel-app /var/www

# Change current user to www-data
USER www-data

EXPOSE 8000

CMD ["tail", "-f", "/dev/null"]