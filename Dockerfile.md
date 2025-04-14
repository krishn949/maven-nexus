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


🧱 Why Use Two FROMs (Multi-Stage Build)?
Using two FROMs creates two separate stages in the Docker build process:

🟨 Stage 1: The Build Stage

dockerfile

Copy

Edit

FROM maven as build

WORKDIR /app

COPY . .

RUN mvn install

This stage is responsible for building your application using Maven.

It has everything needed to compile code: Maven, a full JDK, dependencies, etc.

Once the build is complete, it creates a .jar file (e.g., target/Uber.jar).

⚠️ This image ends up being pretty large because it includes build tools and cache files.

🟩 Stage 2: The Runtime Stage

dockerfile

Copy

Edit

FROM openjdk:11.0

WORKDIR /app

COPY --from=build /app/target/Uber.jar /app/

EXPOSE 9090

CMD ["java","-jar","uber.jar"]

This second stage is much smaller and cleaner.

It only includes what’s needed to run the application — in this case, just the JDK and your .jar file.

No Maven, no source code, no build files = smaller and more secure image.

✅ Benefits of Multi-Stage Builds
Smaller final image size

You're not shipping Maven or source files in production.

Better separation of concerns

One stage handles building, the other just runs the app.

Improved security

The runtime image has fewer tools and less surface area for vulnerabilities.

Cleaner Docker layers

Only the final result is in your production container.

🔍 Real-Life Analogy
Think of it like:

Stage 1 (build): A kitchen where you cook the meal.

Stage 2 (run): A clean plate where you serve just the food.

You don't want to serve your guests the entire kitchen—you just want to give them the finished dish.
