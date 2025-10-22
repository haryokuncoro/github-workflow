# Stage 1: Build
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Copy file pom.xml dan unduh dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy seluruh source code
COPY src ./src

# Build JAR (hasilnya github-workflow.jar)
RUN mvn clean package -DskipTests

# Stage 2: Runtime (lebih ringan)
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy hasil build (jar spesifik)
COPY --from=build /app/target/github-workflow.jar app.jar

# Expose port aplikasi
EXPOSE 8080

# Jalankan aplikasi
ENTRYPOINT ["java", "-jar", "app.jar"]
