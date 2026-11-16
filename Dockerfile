FROM tomcat:10.1-jdk17-temurin

WORKDIR /usr/local/tomcat/webapps/

COPY target/ticket-reservation.war ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
