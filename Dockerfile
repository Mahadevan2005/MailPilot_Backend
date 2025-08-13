# Step 1: Build the app using Maven with Java 21
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /Email-Assistant

# Copy all files and make mvnw executable
COPY . .
RUN chmod +x mvnw

# Build the Spring Boot jar
RUN ./mvnw clean package -DskipTests

# Step 2: Use a lightweight Java 21 runtime image
FROM eclipse-temurin:21-jdk
WORKDIR /Email-Assistant

# Copy the built jar from the build stage (use forward slashes!)
COPY --from=build /Email-Assistant/target/Email-Assistant-0.0.1-SNAPSHOT.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
