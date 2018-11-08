# influxdb1.6

~~~
列出全部数据库
http://192.168.0.4:8086/query?q=show%20DATABASES
创建数据库
http://192.168.0.4:8086/query?q=CREATE DATABASE mydb
创建表
http://192.168.0.4:8086/query?pretty=true&db=mydb&q=CREATE RETENTION POLICY bar ON mydb DURATION INF REPLICATION 1 DEFAULT
查询多少条
http://192.168.0.4:8086/query?pretty=true&db=mydb&q=SELECT count(value) FROM bar

http://192.168.0.4:8086/write 【post提交 json】
{"database" : "mydb", "retentionPolicy" : "bar", "points": [{"measurement": "network", "tags": {"host": "server01","region":"uswest"},"time": "2015-02-26T22:01:11.703Z","fields": {"rx": 2342,"tx": 9804}}]}
~~~

~~~
docker volume create --name influxdb

docker run --restart=always -p 8086:8086 -p 2003:2003 --name influxdata \
 -v influxdb:/var/lib/influxdb -d zhoujinshi/influxdata1.6

docker run --rm \
      -e INFLUXDB_DB=db0 \
      -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=fox_qh \
      -e INFLUXDB_USER=telegraf -e INFLUXDB_USER_PASSWORD=fox_qh \
      -v influxdb:/var/lib/influxdb \
      -d zhoujinshi/influxdata1.5  /init-influxdb.sh

docker volume ls -qf dangling=true

docker volume rm $(docker volume ls -qf dangling=true)

docker volume ls
~~~