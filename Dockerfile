# Base stage to set php version
FROM php:8.3-fpm AS base

RUN apt-get update && apt-get install -y \
  git \
  curl \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  zip \
  unzip

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

WORKDIR /app


# Composer stage to set composer version
FROM composer:2.8.1 AS composer


# Dev deps to cope composer and install all dependencies from composer
FROM base AS dev-deps
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY ./composer.* ./
RUN /usr/local/bin/composer install --no-interaction


# Copy all files to development image
FROM dev-deps AS development
COPY --chown=www-data:www-data . .
EXPOSE 9000


# Only install production composer dependencies
FROM base AS prod-deps
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY ./composer.* ./
RUN /usr/local/bin/composer install --no-dev --no-scripts


# Copy depencencies from prod-deps so composer isn't also packaged
# with the image
FROM base AS production
COPY --from=prod-deps --chown=www-data:www-data /app/vendor ./vendor
COPY --chown=www-data:www-data . .
EXPOSE 9000
