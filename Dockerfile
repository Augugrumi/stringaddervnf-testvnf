FROM openjdk:jdk-slim as builder

RUN mkdir -p /build/
WORKDIR /build/

COPY . /build/

# Install maven
RUN apt-get update &&  \
    apt-get install -y maven git

# Builds the launcher
RUN mvn package && \
    mv target/addervnf-1.0-SNAPSHOT-jar-with-dependencies.jar /stringaddervnf.jar

FROM openjdk:8-jre-alpine
LABEL license="GPLv3+"

ENV PORT=80 STRING_TO_ADD=vnf

WORKDIR /srv/

COPY --from=builder /stringaddervnf.jar /stringaddervnf.jar
EXPOSE 80

ENTRYPOINT ["java", "-jar", "stringaddervnf.jar", "$STRING_TO_ADD", "80"]
