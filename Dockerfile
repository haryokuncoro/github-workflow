# -- STAGE 1: BUILDER (Tahap Pembangunan) --
# Gunakan image dengan Maven dan JDK untuk proses build
FROM maven:3.9.5-openjdk-17 AS builder

# Set working directory untuk tahap build
WORKDIR /app

# Salin pom.xml untuk memungkinkan cache dependensi Maven
# Ini mempercepat build jika pom.xml tidak berubah
COPY pom.xml .

# Unduh dependensi (gunakan perintah "true" agar tidak gagal saat pertama kali)
# Ini adalah trik caching yang canggih
RUN mvn dependency:go-offline -B || true

# Salin semua kode sumber lainnya
COPY src ./src

# Build aplikasi Anda
# Pastikan nama JAR sesuai dengan yang akan disalin (misal: target/github-workflow.jar)
RUN mvn clean package -DskipTests

# ----------------------------------------------------
# -- STAGE 2: RUNNER (Tahap Eksekusi) --
# Gunakan image Java JRE yang ramping untuk menjalankan aplikasi
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Salin JAR yang sudah di-build dari tahap 'builder'
# Ganti 'github-workflow.jar' dengan nama JAR yang benar jika berbeda
COPY --from=builder /app/target/github-workflow.jar app.jar

# Set default port dari environment variable (ini hanya dokumentasi/nilai default)
ENV PORT 8080

# Expose port (opsional, untuk dokumentasi)
EXPOSE 8080

# Jalankan Spring Boot
ENTRYPOINT ["java","-jar","app.jar"]