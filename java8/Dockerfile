FROM alpine:3.4

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ENV TZ Asia/shanghai
ADD localtime /etc/localtime;

RUN apk update && echo "https://mirrors.aliyun.com/alpine/latest-stable/main/" >> /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories \
    && apk add --no-cache curl && echo $TZ > /etc/timezone

RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u111
ENV JAVA_ALPINE_VERSION 8.111.14-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]