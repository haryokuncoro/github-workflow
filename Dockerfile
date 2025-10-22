# Stage build
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom dan src
COPY pom.xml .
COPY src ./src

# Build jar fat/self-contained, skip tests (optional)
RUN mvn clean package -DskipTests

# Stage runtime
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy jar dari stage build
COPY --from=build /app/target/github-workflow.jar app.jar

# Jalankan jar
ENTRYPOINT ["java","-jar","/app/app.jar"]

# Expose port (ubah sesuai application.properties)
EXPOSE 8080
