FROM maven:3.8.1-openjdk-11-slim as Builder
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build
COPY pom.xml ./
COPY src ./src

RUN mvn clean package
COPY target/euraka-server-${VERSION}.jar ./target/application.jar

FROM openjdk:11.0.8-jre-slim
WORKDIR /app

COPY --from=Builder /build/target/application.jar ./

CMD java -jar ./application.jar