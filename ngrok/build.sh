#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ "${SUBDOMAIN}" == "**None**" ]; then
    echo "Please set SUBDOMAIN"
    exit 1
fi

cd ${MY_FILES}
if [ ! -f "${MY_FILES}/ca.crt" ]; then
    openssl genrsa -out ca.key 2048
    openssl req -new -x509 -nodes -key ca.key -subj "/C=CN/O=Cnbbx/CN=${DOMAIN}" -days 10000 -out ca.crt
    openssl genrsa -out server.key 2048
    openssl req -new -key server.key -subj "/C=CN/O=Cnbbx/CN=${SUBDOMAIN}" -out server.csr
    openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 10000
fi

cp -r ca.crt /ngrok/assets/client/tls/ngrokroot.crt

if [ ! -f "/ngrok/bin/ngrokd" ]; then
	cd /ngrok && make release-server && GOOS=windows GOARCH=amd64 make release-client && cp -r /ngrok/bin/* ${MY_FILES}/bin && echo "build ok !" && cd ${MY_FILES}
fi