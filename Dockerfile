FROM registry.access.redhat.com/ubi8/openjdk-21@sha256:3cfa96520aadc68fbde8b7393d6b49216d82d61f6bbdf63c8576b0ca4a0b7ea9 AS build
ARG WORK_DIR="/usr/src/app"
WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}

USER 0

RUN microdnf install -y dnf && dnf update -y && dnf install -y maven

RUN ["mvn", "-DskipTests", "clean", "install"]

USER 185

FROM registry.access.redhat.com/ubi8/openjdk-21@sha256:3cfa96520aadc68fbde8b7393d6b49216d82d61f6bbdf63c8576b0ca4a0b7ea9
ARG WORK_DIR="/usr/src/app"
WORKDIR ${WORK_DIR}

USER 0

COPY --chown=185:0 --from=build ${WORK_DIR}/target/hello-0.0.1-SNAPSHOT.jar ${WORK_DIR}

USER 185

EXPOSE 8080 8443

CMD ["java", "-jar", "hello-0.0.1-SNAPSHOT.jar"]