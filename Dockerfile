FROM tomcat:11.0.0

WORKDIR /usr/local/tomcat/webapps

COPY jasper-bin /usr/local/tomcat/webapps/jasper-bin

EXPOSE 8080

CMD ["catalina.sh","run"]