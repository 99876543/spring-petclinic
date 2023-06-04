# Clone the code
FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/wakaleo/game-of-life.git

# Run from Maven official image and start build 
FROM maven:3-amazoncorretto-8 AS builder
COPY --from=vcs /game-of-life /game-of-life
RUN cd /game-of-life && mvn package

# Create a Final stage
FROM tomcat:9-jdk8
LABEL author="Adnan" organization="qt"

# Copy files from previous built application 
COPY --from=builder /game-of-life/gameoflife-web/target/*.war /usr/local/tomcat/webapps/gameoflife.war

# Expose the Port
EXPOSE 8080

# Docker compose file for this 

version: '3'
services:
  gameoflife:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 8080:8080





























      