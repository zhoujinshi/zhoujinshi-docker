FROM zhoujinshi/php7-cli

LABEL maintainer="jinge <admin@cnbbx.com>" version="1.0"

ENV SWOOLE_VERSION=4.2.1 \
    REDIS_VERSION=4.1.1

RUN set -ex \
        && cd /tmp \
        # && curl -SL "http://pecl.php.net/get/swoole-${SWOOLE_VERSION}.tgz" -o swoole.tgz \
		&& wget -O swoole.tgz "http://www.cntrunk.com/swoole-${SWOOLE_VERSION}.tgz" \
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
		&& rm /tmp/*

CMD ["php", "-a"]