FROM tomcat:10

RUN apt-get update && apt-get install -y tar

ENV JASPERREPORTS_HOME /usr/local/tomcat/webapps/jasperserver

COPY jasperreports-8.2.0.tar.gz /tmp/jasperreports

RUN  tar xvfz /tmp/jasperreports/jasperreports-8.2.0.tar.gz 

# COPY jasperreports-server-cp-8.2.0-bin /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["catalina.sh", "run"]