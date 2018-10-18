#!/bin/sh
set -e

cp -r base.pem /ngrok/assets/client/tls/ngrokroot.crt && cd /ngrok
GOOS=linux GOARCH=386 make release-client
GOOS=linux GOARCH=amd64 make release-client
GOOS=windows GOARCH=386 make release-client
GOOS=windows GOARCH=amd64 make release-client
GOOS=darwin GOARCH=386 make release-client
GOOS=darwin GOARCH=amd64 make release-client
GOOS=linux GOARCH=arm make release-client
cp -r /ngrok/bin ${MY_FILES}/bin

echo "build ok !"
