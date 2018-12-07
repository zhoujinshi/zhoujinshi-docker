> 容器名称 cnbbx_redis

~~~
no db 集群配置：
docker network create redis-net && docker network prune

docker run --restart=always --name cnbbx_redis_2 --sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_3 --sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_4 --sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_5 --sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_6 --sysctl net.core.somaxconn=1024 -d zhoujinshi/redis5 && \
docker run --restart=always --name cnbbx_redis_1 --sysctl net.core.somaxconn=1024 --link cnbbx_redis_2 --link cnbbx_redis_3 \
--link cnbbx_redis_4 --link cnbbx_redis_5 --link cnbbx_redis_6 -p 6379:6379 -d zhoujinshi/redis5




docker inspect cnbbx_redis_1 cnbbx_redis_2 cnbbx_redis_3 cnbbx_redis_4 \
cnbbx_redis_5 cnbbx_redis_6 | grep \"IPAddress\"| grep 172

docker exec -it cnbbx_redis_1 /bin/sh

/usr/local/bin/redis-cli --cluster create cnbbx_redis_2:6379 cnbbx_redis_3:6379 \
cnbbx_redis_4:6379 cnbbx_redis_5:6379 cnbbx_redis_6:6379 --cluster-replicas 1 

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