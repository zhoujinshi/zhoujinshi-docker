> java-1.8-openjdk(8.111.14)

> Apache Maven 3.5.4

### RUN 运行代码

~~~
HOST_ZONE=http://admin:123456@cnbbx-center:8761/eureka\
,http://admin:123456@cnbbx-center2:8762/eureka

docker run --restart=always --name cnbbx-center -v `pwd`/cnbbx-center-1.0-SNAPSHOT.jar:/app.jar \
-v `pwd`/logs:/var/logs/java/ -v maven-repo:/root/.m2 -p 8761:8761 --expose=8761 \
-d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8761 \
--eureka.client.serviceUrl.defaultZone=http://admin:123456@$HOST_IP:8762/eureka

docker run --restart=always --name cnbbx-center2 -v `pwd`/cnbbx-center-1.0-SNAPSHOT.jar:/app.jar \
-v `pwd`/logs:/var/logs/java/ -v maven-repo:/root/.m2 -p 8762:8762 --expose=8762 \
-d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8762 \
--eureka.client.serviceUrl.defaultZone=http://admin:123456@$HOST_IP:8761/eureka

docker run --name cnbbx-provider -v `pwd`/cnbbx-provider-1.0-SNAPSHOT.jar:/app.jar \
-v `pwd`/logs:/var/logs/java/ -v maven-repo:/root/.m2 -p 8762:8762 --expose=8762 \
-d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8762 \
--link=cnbbx-center:cnbbx/java8-mvn3 --link=cnbbx-center2:cnbbx/java8-mvn3 \
--eureka.client.serviceUrl.defaultZone=$HOST_ZONE

docker run --name cnbbx-consumer -v `pwd`/cnbbx-consumer-1.0-SNAPSHOT.jar:/app.jar \
-v `pwd`/logs:/var/logs/java/ -v maven-repo:/root/.m2 -p 8763:8763 --expose=8763 \
-d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8763 \
--link=cnbbx-center:cnbbx/java8-mvn3 --link=cnbbx-center2:cnbbx/java8-mvn3 \
--eureka.client.serviceUrl.defaultZone=$HOST_ZONE

docker run --restart=always --name cnbbx-admin-server -v `pwd`/cnbbx-admin-server-1.0-SNAPSHOT.jar:/app.jar \
-v `pwd`/logs:/var/logs/java/ -v maven-repo:/root/.m2 -p 8080:8080 --expose=8080 \
-d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8080 \
--link=cnbbx-center:cnbbx/java8-mvn3 --link=cnbbx-center2:cnbbx/java8-mvn3 \
--eureka.client.serviceUrl.defaultZone=$HOST_ZONE
~~~
### 重用Maven本地存储库
本地Maven存储库可以跨容器重用，方法是创建一个卷并挂载它 /root/.m2.
~~~
docker volume create --name maven-repo
docker run --rm -it -v maven-repo:/root/.m2 cnbbx/java8-mvn3 mvn archetype:generate # will download artifacts
~~~
### 其他参数
~~~
echo --eureka.instance.hostname=$HOST_IP --eureka.instance.preferIpAddress=true \
--eureka.instance.ipAddress=$HOST_IP \
--eureka.client.serviceUrl.defaultZone=http://user:123456@$HOST_IP:8761/eureka
~~~
### 更具pom.xml下载jar
mvn -f pom.xml dependency:copy-dependencies


docker run --restart=always --name office-server -v `pwd`/office-0.0.1-SNAPSHOT.jar:/app.jar -p 8000:8000 --expose=8000 -d cnbbx/java8-mvn3 java -jar /app.jar --server.port=8000