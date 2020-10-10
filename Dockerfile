FROM openjdk:16-jdk-alpine

WORKDIR /app
COPY . /app

ENTRYPOINT ./mvnw spring-boot:run