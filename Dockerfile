FROM openjdk:11.0
LABEL maintainer= "Krishna <nagasriyansh@gmail.com>"
WORKDIR /app
COPY /target/Uber.jar /app/Uber.jar
EXPOSE 9090
CMD ["java", "-jar", "Uber.jar"]

