FROM golang:alpine

RUN apk add --no-cache git make openssl

RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok

ENV DOMAIN **None**
ENV SUBDOMAIN **None**
ENV MY_FILES /myfiles
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

ADD *.sh /usr/local/bin/

WORKDIR $MY_FILES

EXPOSE 4443
EXPOSE 80
EXPOSE 443

CMD ["server.sh"]