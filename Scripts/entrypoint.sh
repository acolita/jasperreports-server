#!/bin/bash
set -e

/wait-for-it.sh $DB_HOST:$DB_PORT --timeout=60 -- echo "Database server is up"

export BUILDOMATIC_MODE=script

if [ -f "/.do_deploy_jasperserver" ]; then
    pushd /usr/src/jasperreports-server/buildomatic
        
    cp sample_conf/${DB_TYPE}_master.properties default_master.properties
        
    sed -i -e "s|^appServerDir.*$|appServerDir = $CATALINA_HOME|g" default_master.properties
        
    sed -i -e "s|^dbHost.*$|dbHost=$DB_HOST|g; s|^dbPort.*$|dbPort=$DB_PORT|g; s|^dbUsername.*$|dbUsername=$DB_USER|g; s|^dbPassword.*$|dbPassword=$DB_PASSWORD|g; s|^# js.dbName=.*$|js.dbName=$DB_NAME|g" default_master.properties

    sed -i -e "s|^# webAppNameCE.*$|webAppNameCE = $WEBAPP_NAME|g" default_master.properties

    echo "encrypt.done=true" >> default_master.properties

    sed -i -e "s|^js.dbName.*$|js.dbName=$DB_NAME|g" ./conf_source/db/${DB_TYPE}/db.template.properties

    ./js-ant create-js-db || true 
    ./js-ant gen-config
    ./js-ant init-js-db-ce 
    ./js-ant import-minimal-ce 
    ./js-ant deploy-webapp-ce

    echo "tbeller.usejndi=false" > $CATALINA_HOME/webapps/$WEBAPP_NAME/WEB-INF/classes/resfactory.properties
   
    rm /.do_deploy_jasperserver

    popd
fi

catalina.sh run