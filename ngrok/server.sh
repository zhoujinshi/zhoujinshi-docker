#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -f "${MY_FILES}/ca.crt" ]; then
    echo "certificate is not build,will be build it now..."
    build.sh
fi

if [ ! -f "${MY_FILES}/bin/ngrokd" ]; then
    echo "ngrokd is not build,will be build it now..."
    build.sh
fi

${MY_FILES}/bin/ngrokd -tlsKey=${MY_FILES}/server.key -tlsCrt=${MY_FILES}/server.crt -domain="${DOMAIN}" -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}