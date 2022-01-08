FROM openjdk:11.0.8-jre-slim
WORKDIR /app

COPY target/euraka-server-0.0.1-SNAPSHOT.jar ./application.jar
EXPOSE 8761

CMD java -jar ./application.jar