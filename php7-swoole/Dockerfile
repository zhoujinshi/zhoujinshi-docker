FROM cnbbx/php7-fpm

LABEL maintainer="jinge <admin@cnbbx.com>" version="1.0"

COPY docker_run.sh /docker_run.sh

RUN set -ex \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
	argon2-dev \
	coreutils \
	curl-dev \
	libedit-dev \
	libsodium-dev \
	libxml2-dev \
	libzip-dev \
	openssl-dev \
	sqlite-dev \
	libwebp \
	libwebp-dev \
	freetype \
	freetype-dev \
	libpng \
	libpng-dev \
	jpeg-dev \
	libjpeg \
	libjpeg-turbo \
	libjpeg-turbo-dev \
	freetds \
	freetds-dev \
	wget \
	# php extension: swoole
	&& cd /tmp/ && wget -O swoole.tar.gz https://github.com/swoole/swoole-src/archive/v4.6.0.tar.gz \
	&& tar -zxC /tmp/ -f swoole.tar.gz && rm -rf swoole.tar.gz && cd swoole-src-4.6.0 && ls -hl \
	&& phpize && ./configure --enable-coroutine \
	--enable-openssl  \
	--enable-http2  \
	--enable-async-redis \
	--enable-sockets \
	--enable-mysqlnd && make && make install \
	&& apk del .phpize-deps && apk add libstdc++ \
	&& docker-php-ext-enable swoole \
	&& rm -rf /tmp/* \
	&& rm /usr/local/etc/php/conf.d/docker-php-conf-xdebug.ini \
	&& rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
	&& php -m

CMD ["/bin/sh", "/docker_run.sh"]
