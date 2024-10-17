# Laravel + Docker + REST API test
This is an example setup for a Laravel based REST API, containerised using Docker.

## Assumption to run code
Docker installed with docker compose.

## Laravel
Stater project used for Laravel base at version 11.9.

Create a new folder in the root directory of the project called **.env** and copy the contents of **.env.example**. Either create manually an APP Key for the **.env** or run: `php artisan key:generate` on the app container and the APP_KEY value will be added for you.

## Docker
The Docker file in the root directory of the project can be used to create a production ready image for the application. Using Docker build stages the image's size has been reduced by only including what is necessary to run the container in production.

### Building production image
To build the production image run:
`docker build -t laravel-docker-api .`

### Development
The *compose.yaml* file can be used to run the project in a development environment. After cloning the files run: `docker compose up --build -w`. This command will build/download the required images and the *-w* flag will watch for changes of files in our local file system.

The compose process includes a reference to the Dockerfile in the root of the project to run the app as well as an nginx container used as a webserver to forward requests to the php-fpm process. As nginx requires access to the files, a volume is created from the files of the app container in order to share readonly access.