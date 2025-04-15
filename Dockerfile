FROM openjdk:11.0
LABEL maintainer= "Krishna"
WORKDIR /app
COPY /target/Uber.jar /app/Uber.jar
CMD ["java", "-jar", "Uber.jar"]

