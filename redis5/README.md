> 容器名称 cnbbx_redis

~~~
no db 集群配置：
docker network create redis-net &&
docker run --restart=always --name cnbbx_redis_1 --net redis-net \
--sysctl net.core.somaxconn=1024 -p 6379:6379 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_2 --net redis-net \
--sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_3 --net redis-net \
--sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_4 --net redis-net \
--sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_5 --net redis-net \
--sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_6 --net redis-net \
--sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5


docker inspect cnbbx_redis_1 cnbbx_redis_2 cnbbx_redis_3 cnbbx_redis_4 \
cnbbx_redis_5 cnbbx_redis_6 | grep \"IPAddress\"| grep 172

docker exec -it cnbbx_redis_1 /bin/sh

/usr/local/bin/redis-cli --cluster create 172.18.0.2:6379 172.18.0.3:6379 \
172.18.0.4:6379 172.18.0.5:6379 172.18.0.6:6379 172.18.0.7:6379 --cluster-replicas 1 

docker rm -f cnbbx_redis_1 cnbbx_redis_2 cnbbx_redis_3 cnbbx_redis_4 \
cnbbx_redis_5 cnbbx_redis_6
~~~

> pro：

~~~
docker run -p 6379:6379 -v /root/redis5/data:/data --name cnbbx_redis \
-d zhoujinshi/redis5

docker run --name cnbbx_redis -d zhoujinshi/redis5 redis-server --appendonly yes
~~~

> cli：

~~~
docker run -it --rm zhoujinshi/redis5 redis-cli
~~~