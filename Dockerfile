FROM public.ecr.aws/docker/library/openjdk:21-ea-17-oraclelinux7
EXPOSE 8080
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]