## stage -1
FROM alpine/git AS vcs
LABEL author="Adnan" project="gameoflife" organization="khaja.tech"
RUN cd / && git clone https://github.com/wakaleo/game-of-life.git

## stage -2
FROM amazoncorretto:11-alpine3.14
LABEL author="Adnan" project="gameoflife" organization="khaja.tech"
ARG user=Adnan
ARG group=Adnangroup
ARG uid=2121
ARG gid=3131
ARG HOME_DIR=/game-of-life
RUN adduser -h "$HOME_DIR" -u ${uid} -g ${gid} -D -s /bin/bash ${user} \
&& addgroup -g ${gid} ${group}

# Build the application
FROM maven:3-amazoncorretto-8 AS builder
COPY --from=vcs /game-of-life / game-of-life
RUN cd /game-of-life && mvn package


# Create a final image
FROM tomcat:9-jdk8
LABEL author="Adnan"
COPY --from=builder /game-of-life/gameoflife-web/target/*.war /usr/local/tomcat/webapps/gameoflife.war
EXPOSE 8080