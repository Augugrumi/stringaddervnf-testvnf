FROM openjdk:jdk-slim as builder

RUN mkdir -p /build/
WORKDIR /build/

COPY . /build/

# Should fix StackOverflow errors
ARG MAVEN_OPTS="-Xms256m -Xmx1024m -Xss1024k"

# Install maven
RUN apt-get update &&  \
    apt-get install -y maven git

# Builds the launcher
RUN git clone https://github.com/Augugrumi/stringaddervnf-testvnf.git && \
    cd stringaddervnf-testvnf && \
    mvn package && \
    mv target/addervnf-1.0-SNAPSHOT-jar-with-dependencies.jar /stringaddervnf.jar

FROM java:8
ENV PORT=8080 STRING_TO_ADD=vnf
WORKDIR /
ADD stringaddervnf-with-dependencies.jar stringaddervnf-with-dependencies.jar
EXPOSE $PORT
CMD java -jar stringaddervnf-with-dependencies.jar $STRING_TO_ADD $PORT
