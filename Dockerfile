FROM tomcat:9.0.65-jdk11-openjdk

ENV JASPERSERVER_VERSION 8.2.0

# Execute all in one layer so that it keeps the image as small as possible
RUN wget "https://sourceforge.net/projects/jr-community-installers/files/Server/TIB_js-jrs-cp_${JASPERSERVER_VERSION}_bin.zip/download" \
         -O /tmp/jasperserver.zip  && \
    unzip /tmp/jasperserver.zip -d /usr/src/ && \
    rm /tmp/jasperserver.zip && \
    mv /usr/src/jasperreports-server-cp-${JASPERSERVER_VERSION}-bin /usr/src/jasperreports-server && \
    rm -r /usr/src/jasperreports-server/samples

COPY resfactory.properties /usr/local/tomcat/webapps/jasperserver/WEB-INF/classes/

ADD wait-for-it.sh /wait-for-it.sh

ADD entrypoint.sh /entrypoint.sh
ADD .do_deploy_jasperserver /.do_deploy_jasperserver
    
RUN chmod a+x /entrypoint.sh && \
    chmod a+x /wait-for-it.sh

ENTRYPOINT ["/entrypoint.sh"]