# Gunakan OpenJDK 17
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy jar hasil build Maven
COPY target/github-workflow.jar app.jar

# Set default port dari environment variable
ENV PORT 8080

# Jalankan Spring Boot
ENTRYPOINT ["java","-jar","app.jar"]
