FROM openjdk:11.0
WORKDIR /app
COPY /target/Uber.jar /app/Uber.jar
EXPOSE 9090
CMD ["java", "-jar", "Uber.jar"]

