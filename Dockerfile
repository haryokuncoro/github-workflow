# Gunakan base image Java 17
FROM eclipse-temurin:17-jdk-alpine

EXPOSE 8080

ADD target/github-workflow.jar github-workflow.jar
ENTRYPOINT ["java","-jar", "github-workflow.jar"]