# Laravel + Docker + REST API test

This is an example setup for a Laravel based REST API, containerised using Docker.

## Assumption to run code

Docker installed with docker compose.

## Docker

The Docker file in the root directory of the project can be used to create a production ready image for the application. Using Docker build stages the image's size has been reduced by only including what is necessary to run the container in production.

### Building production image

To build the production image run:
`docker build -t laravel-docker-api .`

### Development

The _compose.yaml_ file can be used to run the project in a development environment. After cloning the files run: `docker compose up --build -d`. This command will build/download the required images and the _-d_ flag will run in detached mode.

The compose process includes a reference to the Dockerfile in the root of the project to run the app as well as an Nginx container used as a webserver to forward requests to the php-fpm process. As Nginx requires access to the files, a volume is created from the host to Nginx. In order to have live updates the host files are also connected to the app container even though the app image is created with all files already there.

### MySQL

A separate container is used for MySQL and the containers port is exposed to the localhost on port 3307. A names volume has been created to persist the DB data beyond the life of the container.

### Deployment

In a Kubernetes like deployment, to connect Nginx to the container code, a named volume should be created from the app container and referenced in the Nginx container.

## Laravel

Stater project used for Laravel base at version 11.9.

Create a new folder in the root directory of the project called **.env** and copy the contents of **.env.example**. Either manually create an APP Key for the **.env** or run: `php artisan key:generate` on the app container once docker is running and the APP_KEY value will be added for you.

### Migrations & Seeders

The project includes DB migrations to sync the schema of the project. To run the migrations run: `php artisan migrate:fresh`, you can also add the `--seed` flag to the fresh migrate command in order to run the DB seeder, which will fill the DB with test data, including a test User and Pages.
