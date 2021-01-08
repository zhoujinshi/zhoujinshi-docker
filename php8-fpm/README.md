# How to use this image
### Create a Dockerfile in your PHP project
~~~
FROM cnbbx/php8-fpm
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
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp cnbbx/php8-fpm php your-script.php
~~~