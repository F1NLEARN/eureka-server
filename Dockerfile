FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /workspace

COPY eureka-server/gradle gradle
COPY eureka-server/gradlew gradlew
COPY eureka-server/build.gradle build.gradle
COPY eureka-server/settings.gradle settings.gradle
COPY eureka-server/src src

RUN chmod +x gradlew && ./gradlew bootJar -x test --no-daemon

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=builder /workspace/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]