FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/github-workflow.jar /app/my-api.jar

ENTRYPOINT ["java", "-jar", "my-api.jar"]