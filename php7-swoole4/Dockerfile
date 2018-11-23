FROM zhoujinshi/php7-cli

LABEL maintainer="jinge <admin@cnbbx.com>" version="1.0"

ENV SWOOLE_VERSION=4.2.8 \
    REDIS_VERSION=4.2.8

RUN set -ex \
        && cd /tmp \
		&& wget -O swoole.tgz "http://oa.cntrunk.com/swoole-4.2.8.tgz" \
        && ls -alh \
        && apk update \
        && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
        # for swoole ext
        && apk add --no-cache \
         linux-headers \
         openssl-dev \
         libstdc++ \
         librdkafka-dev \
        # php extension: swoole
        && pecl install swoole.tgz \
        && docker-php-ext-enable swoole \
        && apk del .phpize-deps \
		&& rm -rf /tmp/* \
		&& rm /usr/local/etc/php/conf.d/xdebug.ini

CMD ["php", "-a"]