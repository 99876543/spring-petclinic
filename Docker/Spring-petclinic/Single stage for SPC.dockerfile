FROM alpine
LABEL author="Adnan"
RUN apk update
RUN apk add git
RUN apk add maven
RUN git clone https://github.com/spring-projects/spring-petclinic.git
RUN cd /spring-petclinic && mvn package
WORKDIR /spring-petclinic/target/
EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic-3.0.0-SNAPSHOT.jar"]