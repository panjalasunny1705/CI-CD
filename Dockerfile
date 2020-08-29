FROM maven:3.6.0-jdk-11-slim as build
#ARG PHASE
ARG application
ARG version
ARG phase
WORKDIR /app
COPY src  ./src
COPY pom.xml .
RUN mvn -f ./pom.xml clean ${phase}

FROM openjdk:11-jre-slim 
USER appuser
COPY --from=build /app/target/${application}-${version}-SNAPSHOT.jar /app/${application}-${version}-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/${application}-${version}-SNAPSHOT.jar"]