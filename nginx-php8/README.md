# What is nginx?

Nginx (pronounced "engine-x") is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors. It also has a proof of concept port for Microsoft Windows.

> [wikipedia.org/wiki/Nginx](https://en.wikipedia.org/wiki/Nginx)

![logo](https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/nginx/logo.png)

# How to use this image

## Hosting some simple static content

```console
$ docker run --name cnbbx_nginx -p 80:80 -p 1935:1935 -v /var/www/html:/var/www/html -v `pwd`/vhosts/:/etc/nginx/conf.d/ -v `pwd`/nginx.conf:/etc/nginx/nginx.conf -d cnbbx/nginx-php8
```

Alternatively, a simple `Dockerfile` can be used to generate a new image that includes the necessary content (which is a much cleaner solution than the bind mount above):

```dockerfile
FROM cnbbx/nginx-php8
COPY static-html-directory /usr/share/nginx/html
```

Place this file in the same directory as your directory of content ("static-html-directory"), run `docker build -t some-content-nginx .`, then start your container:

```console
$ docker run --name cnbbx-nginx -d cnbbx/nginx-php8
```

## Exposing external port

```console
$ docker run --name cnbbx-nginx -d -p 8080:80 cnbbx/nginx-php8
```

Then you can hit `http://localhost:8080` or `http://host-ip:8080` in your browser.

## Complex configuration

```console
$ docker run --name my-custom-nginx-container -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d cnbbx/nginx-php8
```

For information on the syntax of the nginx configuration files, see [the official documentation](http://nginx.org/en/docs/) (specifically the [Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure)).

If you wish to adapt the default configuration, use something like the following to copy it from a running nginx container:

```console
$ docker run --name tmp-nginx-container -d cnbbx/nginx-php8
$ docker cp tmp-nginx-container:/etc/nginx/nginx.conf /host/path/nginx.conf
$ docker rm -f tmp-nginx-container
```

This can also be accomplished more cleanly using a simple `Dockerfile` (in `/host/path/`):

```dockerfile
FROM cnbbx/nginx-php8
COPY nginx.conf /etc/nginx/nginx.conf
```

If you add a custom `CMD` in the Dockerfile, be sure to include `-g daemon off;` in the `CMD` in order for nginx to stay in the foreground, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!

Then build the image with `docker build -t custom-nginx .` and run it as follows:

```console
$ docker run --name my-custom-nginx-container -d custom-nginx
```

### Using environment variables in nginx configuration

Out-of-the-box, nginx doesn't support environment variables inside most configuration blocks. But `envsubst` may be used as a workaround if you need to generate your nginx configuration dynamically before nginx starts.

Here is an example using docker-compose.yml:
```yaml
web:
  image: nginx
  volumes:
   - ./mysite.template:/etc/nginx/conf.d/mysite.template
  ports:
   - "8080:80"
  environment:
   - NGINX_HOST=foobar.com
   - NGINX_PORT=80
  command: /bin/bash -c "envsubst < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
```

The `mysite.template` file may then contain variable references like this:

`listen       ${NGINX_PORT};
`

## Running nginx in read-only mode

To run nginx in read-only mode, you will need to mount a Docker volume to every location where nginx writes information. The default nginx configuration requires write access to `/var/cache` and `/var/run`. This can be easily accomplished by running nginx as follows:

```console
$ docker run -d -p 80:80 --read-only -v $(pwd)/nginx-cache:/var/cache/nginx -v $(pwd)/nginx-pid:/var/run nginx
```

If you have a more advanced configuration that requires nginx to write to other locations, simply add more volume mounts to those locations.

## Running nginx in debug mode

Images since version 1.9.8 come with `nginx-debug` binary that produces verbose output when using higher log levels. It can be used with simple CMD substitution:

```console
$ docker run --name my-nginx -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx nginx-debug -g 'daemon off;'
```

Similar configuration in docker-compose.yml may look like this:

```yaml
web:
  image: nginx
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf:ro
  command: [nginx-debug, '-g', 'daemon off;']
```

### PHP调用：

~~~

docker run --restart=always --name cnbbx_nginx -p 80:80 -p 1935:1935 -p 443:443 -v /root/server/www:/var/www/html \
-v /root/server/nginx:/etc/nginx/conf.d/ -v /root/server/ssl:/ssl -v /root/server/logs:/var/log/nginx  \
--link=cnbbx_mysql:cnbbx/mysql8 -d cnbbx/nginx-php8

~~~