ARG REGISTRY=docker.io

# Build
FROM ${REGISTRY}/maven:3.8.6-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Package
FROM ${REGISTRY}/openjdk:11-jre-slim
COPY --from=build /home/app/target/backend-app.jar backend-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "backend-app.jar"]