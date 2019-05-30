### docker run
~~~
docker run --restart=always --name cnbbx_ngrok -v /data/ngrok:/myfiles -p 3080:80 \
-p 3443:443 -p 4443:4443 -p 9000-9100:9000-9100 -e DOMAIN='web.cntrunk.com' \
-e SUBDOMAIN='*.web.cntrunk.com' cnbbx/ngrok
~~~
### build client
~~~
docker exec -it cnbbx_ngrok client.sh
~~~