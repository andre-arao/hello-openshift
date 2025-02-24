FROM openjdk:21-jdk-slim AS build
LABEL MAINTAINER=sefaz-rj
VOLUME /tmp
ARG WORK_DIR="/usr/src/app"
WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}

RUN apt-get update && apt-get install -y maven

RUN ["mvn", "-DskipTests", "clean", "package"]

FROM registry.access.redhat.com/ubi8/openjdk-21@sha256:3cfa96520aadc68fbde8b7393d6b49216d82d61f6bbdf63c8576b0ca4a0b7ea9
LABEL MAINTAINER=sefaz-rj
VOLUME /tmp
ARG WORK_DIR="/usr/src/app"
WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}

USER 185

COPY --from=build ${WORK_DIR}/target/hello-0.0.1-SNAPSHOT.jar ${WORK_DIR}

EXPOSE 8080

CMD ["java", "-jar", "hello-0.0.1-SNAPSHOT.jar"]