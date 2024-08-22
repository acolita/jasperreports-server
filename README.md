# JasperReports Server CE Docker 
JasperReports Server Docker Image Build and Deployment.

This project is a Docker image based on the docker-jasperserver image created by Retriever Communications.

## License
docker-jasperserver: The base image used in this project is licensed under the MIT License, as provided by Retriever Communications.

### Note
Please refer to the [LICENSE](./LICENSE) file for details about the base image's license.

## Building the Docker Image
To execute the Docker build, run the following command:
> docker build -t {IMAGE_TITLE} {DOCKERFILE_DIRECTORY}

-t indicates the "title" of the image that will be created.

{DOCKERFILE_DIRECTORY} indicates the directory where the Dockerfile is located.

## Preparing the Database
Before running the JasperReports Server Container, it's necessary to prepare the database. There are two ways we can do this:
1 - Create a network where both the JasperReports Container and the database Container are connected.
Use the following command to create the Network:
> docker network create {NETWORK_NAME}

After that, add the following snippet to the docker run command (explained below) for both Containers:
> --network {NETWORK_NAME}

2 - Link to the database Container by adding the following snippet to the docker run command: 
> --link {DB_CONTAINER_NAME}:{DB_TYPE}

## Running JasperReports Server
To start the Container, run the docker run command as follows:
> docker run -d   --name {CONTAINER_NAME}  -p 8080:8080 \
> -e DB_TYPE={DB_TYPE} -e CATALINA_HOME=/usr/local/tomcat \
> -e DB_NAME={DB_NAME} -e DB_HOST={DB_HOST} -e DB_PORT={DB_PORT}\
>  -e DB_USER={DB_USER} -e DB_PASSWORD={DB_PASSWORD} \
> -e WEBAPP_NAME={WEBAPP_NAME} \
> -v /var/lib/docker/volumes/jasperserver-keystore/_data:/root {IMAGE_TITLE}

Each ENV variable used in the command is necessary for the proper configuration of the JasperReports Server. For more context, refer to [entrypoint.sh](Scripts/entrypoint.sh) and default_master.properties (obtained from the TIB_js-jrs-cp{VERSION}_bin.zip package).

## JasperReports Web Login
1 - Access the URL: http://${dockerHost}:8080/jasperserver
2 - Use the following credentials: Username: jasperadmin     Password: jasperadmin

### Additional Information
The image has been adapted for the latest version of JasperReports Server Community Edition, version 8.2.0, so there may be conflicts with previous versions.
This image can be used with PostgreSQL and MySQL databases.
