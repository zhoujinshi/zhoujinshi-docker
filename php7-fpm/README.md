# How to use this image
### Create a Dockerfile in your PHP project
~~~
FROM php:7.2-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./your-script.php" ]
~~~
Then, run the commands to build and run the Docker image:
~~~
$ docker build -t my-php-app .
$ docker run -it --rm --name my-running-app my-php-app
~~~

### Run a single PHP script
For many simple, single file projects, you may find it inconvenient to write a complete Dockerfile. In such cases, you can run a PHP script by using the PHP Docker image directly:
~~~
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.2-cli php your-script.php
~~~