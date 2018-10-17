>容器名称 cnbbx_redis

~~~
no db：
docker run -p 6379:6379 --name cnbbx_redis -d zhoujinshi/redis4

pro：
docker run -p 6379:6379 -v /root/redis4/data:/data --name cnbbx_redis -d zhoujinshi/redis4

docker run --name cnbbx_redis -d zhoujinshi/redis4 redis-server --appendonly yes

cli：
docker run -it --rm zhoujinshi/redis4 redis-cli
~~~