FROM cnbbx/nginx-php7

LABEL maintainer="admin <admin@cnbbx.com>" version="1.0"

RUN apk add tzdata asterisk asterisk-cdr-mysql asterisk-curl asterisk-sample-config asterisk-sounds-en ffmpeg

COPY docker_run.sh /docker_run.sh
COPY *.so /usr/lib/asterisk/modules/
RUN rm -rf /var/spool/asterisk/monitor \
	&& mkdir -p /var/www/html/record \
	&& ln -s /var/www/html/record /var/spool/asterisk/monitor \
	&& rm -rf /var/lib/asterisk/agi-bin \
	&& mkdir -p /var/www/html/app/cti/agi \
	&& ln -s /var/www/html/app/cti/agi /var/lib/asterisk/agi-bin \
	&& chmod -R 777 /var/www

EXPOSE 80
EXPOSE 443
EXPOSE 1935
EXPOSE 5060/udp
EXPOSE 5038
EXPOSE 8000
EXPOSE 10000

STOPSIGNAL SIGTERM

CMD ["/bin/sh","/docker_run.sh"]