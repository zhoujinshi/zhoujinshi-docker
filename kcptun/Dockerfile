FROM centos

LABEL maintainer="admin <admin@cnbbx.com>" version="1.0"

RUN mkdir /root/kcptun && cd /root/kcptun && wget https://github.com/xtaci/kcptun/releases/download/v20200226/kcptun-linux-amd64-20200226.tar.gz && tar -zxvf kcptun-linux-amd64-20200226.tar.gz && rm -f kcptun-linux-amd64-20200226.tar.gz

STOPSIGNAL SIGTERM

CMD ["/root/kcptun/server_linux_amd64"]