FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget && \
    rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR=10 \
    TOMCAT_VERSION=10.1.8 \
    CATALINA_HOME=/opt/tomcat

RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.8/bin/apache-tomcat-10.1.8.tar.gz && \
    tar xvf apache-tomcat-10.1.8.tar.gz && \
    mv apache-tomcat-10.1.8.tar.gz /opt/tomcat

EXPOSE 8080

ENV CATALINA_HOME $CATALINA_HOME

CMD ["$CATALINA_HOME/bin/catalina.sh", "run"]
