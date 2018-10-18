FROM golang:alpine

RUN apk add --no-cache git make openssl

RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok

ENV DOMAIN **None**
ENV MY_FILES /myfiles
ENV TUNNEL_ADDR :3444
ENV HTTP_ADDR :3080
ENV HTTPS_ADDR :3443

ADD *.sh /usr/local/bin/

WORKDIR $MY_FILES

EXPOSE 3444
EXPOSE 3080
EXPOSE 3443

CMD ["server.sh"]
