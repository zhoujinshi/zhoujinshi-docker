### docker run
~~~
docker run --restart=always --name cnbbx_ngrok -v /data/ngrok:/myfiles -p 3080:3080 \
-p 3443:3443 -p 9000:9000 -p 3444:3444 -e DOMAIN='web.cntrunk.com' \
-e SUBDOMAIN='*.web.cntrunk.com' zhoujinshi/ngrok
~~~
### build client
~~~
docker run --rm -it -v /data/ngrok:/myfiles -e DOMAIN='web.cntrunk.com' \
-e SUBDOMAIN='*.web.cntrunk.com' zhoujinshi/ngrok client.sh
~~~