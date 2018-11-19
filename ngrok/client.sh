#!/bin/sh
set -e

cd /ngrok
GOOS=linux GOARCH=amd64 make release-client
GOOS=linux GOARCH=arm make release-client
GOOS=linux GOARCH=386 make release-client
GOOS=darwin GOARCH=amd64 make release-client
GOOS=darwin GOARCH=386 make release-client
GOOS=windows GOARCH=amd64 make release-client
GOOS=windows GOARCH=386 make release-client

cp -r /ngrok/bin ${MY_FILES}/bin

cd ${MY_FILES}

echo "build ok !"