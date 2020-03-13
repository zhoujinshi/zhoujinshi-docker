### PHP调用：

~~~

docker run --restart=always --name cnbbx_v2ray -p 4433:443 -d cnbbx/v2ray

docker cp v2ray.crt cnbbx_v2ray:/etc/v2ray/v2ray.crt

docker cp v2ray.key cnbbx_v2ray:/etc/v2ray/v2ray.key

docker restart cnbbx_v2ray

~~~