# nexus
=====

[![](https://images.microbadger.com/badges/image/cnbbx/java8-nexus3.svg)](https://microbadger.com/images/cnbbx/java8-nexus3)

A Dockerfile for Sonatype Nexus Repository Manager 3, based on Alpine.

To run, binding the exposed port 8081 to the host.

    $ docker run -d -p 8081:8081 --name nexus cnbbx/java8-nexus3
    

Notes
-----

*   Default credentials are: `admin` / `admin123`
    
*   It can take some time (2-3 minutes) for the service to launch in a  
    new container. You can tail the log to determine once Nexus is ready:
    

    $ docker logs -f nexus
    

*   Installation of Nexus is to `/opt/sonatype/nexus`.
    
*   A persistent directory, `/nexus-data`, is used for configuration,  
    logs, and storage.
    
*   Two environment variables can be used to control the JVM arguments
    
    *   `JAVA_MAX_MEM`, passed as -Xmx. Defaults to `1200m`.
        
    *   `JAVA_MIN_MEM`, passed as -Xms. Defaults to `1200m`.
        
    
    These can be used supplied at runtime to control the JVM:
    
        $ docker run -d -p 8081:8081 --name nexus -e JAVA_MAX_MEM=2048M cnbbx/java8-nexus3
        
    
*   As of version 3.4.0, Sonatype [recommends](https://support.sonatype.com/hc/en-us/articles/115006448847#filehandles) increasing the system file descriptor limit. In order to do this in Docker, you need to first make sure that the Docker daemon is configured with a ulimit >= 65536 in the systemd/upstart/daemon.json configuration. You may then include the ulimit on the container run command:
    

    $ docker run -d -p 8081:8081 --ulimit nofile=65536 --name nexus cnbbx/java8-nexus3
    

### SSL

If you want to run Nexus in SSL, you need to create a Java keystore file with your certificate. See the [Jetty documentation](http://www.eclipse.org/jetty/documentation/current/configuring-ssl.html) for help.

You will need to mount your keystore to the appropriate directory and pass in the keystore password as well.

    $ docker run -d -p 8443:8443 --name nexus -v /path/to/your-keystore.jks:/nexus-data/keystore.jks -e JKS_PASSWORD="changeit" cnbbx/java8-nexus3
    

Nexus will now serve its' UI on HTTPS on port 8443 and redirect HTTP requests to HTTPS.

If you are going to run a Docker registry inside of Nexus, you will need to route to internal port 5000 as well.

    $ docker run -d -p 5000:5000 -p 8443:8443 --name nexus -v /path/to/your-keystore.jks:/nexus-data/keystore.jks -e JKS_PASSWORD="changeit" cnbbx/java8-nexus3
    

### Persistent Data

There are two general approaches to handling persistent storage requirements  
with Docker. See [Managing Data in Containers](https://docs.docker.com/userguide/dockervolumes/)  
for additional information.

1.  _Use a data volume container_. Since data volumes are persistent  
    until no containers use them, a container can created specifically for  
    this purpose. This is the recommended approach.
    
        $ docker run -d --name nexus-data cnbbx/java8-nexus3 echo "data-only container for Nexus"
        $ docker run -d -p 8081:8081 --name nexus --volumes-from nexus-data cnbbx/java8-nexus3
        
    
2.  _Mount a host directory as the volume_.
    
        $ docker run --restart=always -p 8081:8081 --name cnbbx_nexus -v nexus-data:/nexus-data -d cnbbx/java8-nexus3

3. download offline indexed
    
        $ docker run -it -v `pwd`/indexer-cli-6.0.0.jar:/indexer-cli-6.0.0.jar -v `pwd`/nexus-maven-repository-index.gz:/nexus-maven-repository-index.gz -v `pwd`/nexus-maven-repository-index.properties:/nexus-maven-repository-index.properties -v `pwd`/indexer:/indexer zhoujinshi/java8 java -jar indexer-cli-6.0.0.jar -u nexus-maven-repository-index.gz -d indexer

>之后，会在D:\index自动生成一个indexer文件夹，大概十几分钟吧，cmd命令执行完毕，indexer文件大小会达到700M多点，然后indexer内的文件拷贝到私服{nexus-home}/sonatype-work/nexus/indexer/central-ctx目录下，重新启动nexus，索引更新完毕！