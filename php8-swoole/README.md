## php8 swoole4.6
> 运行命令：

~~~
docker run --restart=always --name cnbbx_swoole --env COMPUTERNAME=192.168.0.4 -p 9501:9501 -v `pwd`:/root/ -v -d cnbbx/php8-swoole nohup php /root/mics/index.php app=oa port=9501>/dev/null &
~~~
> 支持扩展：

~~~
redis opcache memcached xdebug gd
~~~