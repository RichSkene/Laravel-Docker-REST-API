# Base stage to set php version
FROM php:8.3-fpm-alpine AS base
WORKDIR /app


# Composer stage to set composer version
FROM composer:2.8.1 AS composer


# Dev deps to cope composer and install all dependencies from composer
FROM base AS dev-deps
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY ./composer.* ./
RUN /usr/local/bin/composer install --no-interaction --quiet


# Copy all files to development image
FROM dev-deps AS development
COPY --chown=www-data:www-data . .
EXPOSE 9000


# Only install production composer dependencies
FROM base AS prod-deps
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
COPY ./composer.* ./
RUN /usr/local/bin/composer install --no-dev --no-scripts --quiet


# Copy depencencies from prod-deps so composer isn't also packaged
# with the image
FROM base AS production
COPY --from=prod-deps --chown=www-data:www-data /app/vendor ./vendor
COPY --chown=www-data:www-data . .
EXPOSE 9000
