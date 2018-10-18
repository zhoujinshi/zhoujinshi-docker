#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

cd ${MY_FILES}
if [ ! -f "${MY_FILES}/base.pem" ]; then
    openssl genrsa -out base.key 2048
    openssl req -new -x509 -nodes -key base.key -subj "/CN=${DOMAIN}" -days 10000 -out base.pem
    openssl genrsa -out server.key 2048
    openssl req -new -key server.key -subj "/CN=${DOMAIN}" -out server.csr
    openssl x509 -req -in server.csr -CA base.pem -CAkey base.key -CAcreateserial -out server.crt -days 10000
fi
cp base.key /ngrok/assets/client/tls/ngrokroot.crt
cp server.crt /ngrok/assets/server/tls/snakeoil.crt
cp server.key /ngrok/assets/server/tls/snakeoil.key

if [ ! -f "/ngrok/bin/ngrokd" ]; then
	cd /ngrok && make release-server && echo "build ok !" && cd ${MY_FILES}
fi

