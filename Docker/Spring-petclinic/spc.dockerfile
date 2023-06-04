# Multi Stage Dockerfile for SPC
FROM alpine AS builder

# Add a label 
LABEL author="Adnan"

# Update and install Maven
RUN apk update && apk add git maven

# Clone the code and enter in a working directory
RUN git clone https://github.com/spring-projects/spring-petclinic.git
RUN cd /spring-petclinic && mvn package

# Run from maven image
FROM maven:3-amazoncorretto-17 AS runner

# Select a specific path to build a jarfile 
WORKDIR /spring-petclinic/target/

#Copy it from that path
COPY --from=builder /spring-petclinic/target/spring-petclinic-3.0.0-SNAPSHOT.jar .

# Expose it on port
EXPOSE 8080

# Start the Application
CMD ["java", "-jar", "spring-petclinic-3.0.0-SNAPSHOT.jar"]


