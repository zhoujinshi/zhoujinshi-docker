FROM cnbbx/php7-fpm

LABEL maintainer="jinge <admin@cnbbx.com>" version="1.0"

COPY cmdrun.sh /cmdrun.sh

RUN set -ex \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
	# php extension: swoole
	&& pecl install swoole \
	&& apk del .phpize-deps \
	&& docker-php-ext-enable swoole \
	&& rm -rf /tmp/* \
	&& rm /usr/local/etc/php/conf.d/docker-php-conf-xdebug.ini \
	&& rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
	&& apk add libstdc++ && php -m

CMD ["php", "-a"]