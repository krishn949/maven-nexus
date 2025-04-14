🔹 FROM maven as build
This starts the first stage of the Docker build and names it build.

maven: This is the base image from Docker Hub that includes Maven and a JDK installed—used for compiling Java projects.

as build: This names the stage build, which allows us to refer to it later (in the second stage).

🔹 WORKDIR /app
Sets the working directory inside the Docker container to /app. All subsequent commands will be run from this directory.

🔹 COPY . .
Copies everything from your current project directory (on your host machine) to the /app directory inside the container.

🔹 RUN mvn install
Runs mvn install, which compiles your Java code, runs tests, and packages it into a .jar file. That file will be placed in the target/ directory (usually something like target/Uber.jar).

🧱 At this point, Maven has built your app in the build stage.
🔹 FROM openjdk:11.0
This starts the second stage of the Docker build, based on an OpenJDK 11 image. This stage will contain only the minimal runtime environment, without Maven or any build tools. It's lighter and more secure.

🔹 WORKDIR /app
Again, sets the working directory to /app in this new container stage.

🔹 COPY --from=build /app/target/Uber.jar /app/
This copies the built .jar file (Uber.jar) from the first stage (build) into the second stage's /app/ directory.

--from=build means “get this file from the container we named build.”

/app/target/Uber.jar is the path to the JAR file inside that first container.

/app/ is the destination inside the new container.

🔹 EXPOSE 9090
Tells Docker that the container listens on port 9090. This doesn’t actually open the port but is useful metadata (e.g., for Kubernetes or when running the container).

🔹 CMD ["java","-jar","uber.jar"]
This is the command Docker runs when the container starts.

java -jar uber.jar launches the application.

Note: The JAR file is named Uber.jar in the COPY line, but here it’s uber.jar. Case sensitivity matters, so this might be a typo unless the file is actually uber.jar.

🧾 Summary
This Dockerfile:

Uses Maven to build a Java app into a .jar.

Copies only the resulting .jar into a new, lightweight image with just the JDK.

Runs the .jar with Java when the container starts.
