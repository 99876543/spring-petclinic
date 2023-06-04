sudo apt update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
exit
### docker file to install 
FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y wget && \
    wget https://github.com/wildfly/wildfly/releases/download/26.1.0.Final/wildfly-preview-25.0.1.Final.tar.gz && \
    tar xvf wildfly-25.0.1.Final.tar.gz && \
    rm wildfly-25.0.1.Final.tar.gz && \
    mv wildfly-25.0.1.Final /opt/wildfly
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV JBOSS_HOME /opt/wildfly
EXPOSE 8080
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0" ]


docker run --name some-mysql2 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:8.0


docker volume create mysql_data
docker run -d --name mysql_container -e MYSQL_ROOT_PASSWORD=<password> -v mysql_data:/var/lib/mysql mysql:latest
docker logs mysql_container
docker run -d --name second_container --volumes-from mysql_container <other_container_image>


docker container run -d alpine sleep 1d