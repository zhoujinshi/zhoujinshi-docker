FROM mysql:8.0.19

ENV LANG zh_CN.UTF-8

# Config files
COPY config/ /etc/mysql/

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060
CMD ["mysqld"]