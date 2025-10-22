FROM openjdk:17
EXPOSE 8080
ADD target/github-workflow.jar github-workflow.jar
ENTRYPOINT ["java","-jar","/github-workflow.jar"]