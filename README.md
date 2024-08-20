# JasperReports Server CE Docker 
Contrução da imagem docker e deploy do JasperServer Reports. 
Obs: Baseado/adaptado a partir do repositório da *Retriever Communications* : https://github.com/retrievercommunications/docker-jasperserver/tree/release/7.1.0

## Realizando docker build
Para executar o docker build é necessário rodar o seguinte comando:
> docker build -t {IMAGE_TITLE} {DOCKERFILE_DIRECTORY}

-t indica o "title" da imagem que será criada
{DOCKERFILE_DIRECTORY} indica o diretório onde se encontra o Dockerfile

## Preparando banco de dados
Antes de iniciar o Container do JasperReports Server, é necessário preparar o banco de dados. Para isso, podemos utilizar dois métodos:
1 - Criar um network onde tanto o Container contendo o JasperReports quanto o Container contendo o banco de dados estejam ligados.
Utilize o seguinte comando para criar a Network:
> docker network create {NETWORK_NAME}
Após isso adicione o trecho seguinte ao comando docker run (explicado abaixo) dos dois Containers:
> --network {NETWORK_NAME}

2 - Realizar o Link com o Container que contém o banco de dados adicionando o seguinte trecho ao docker run do próximo passo: 
> --link {DB_CONTAINER_NAME}:{DB_TYPE}

## Iniciando Container
Para iniciar o Container é necessário rodar o comando docker run da seguinte forma:
> docker run -d   --name {CONTAINER_NAME}  -p 8080:8080 -e DB_TYPE={DB_TYPE} -e CATALINA_HOME=/usr/local/tomcat -e DB_NAME={DB_NAME} -e DB_HOST={DB_HOST} -e DB_PORT={DB_PORT} -e DB_USER={DB_USER} -e DB_PASSWORD={DB_PASSWORD} -e WEBAPP_NAME={WEBAPP_NAME} -v /var/lib/docker/volumes/jasperserver-keystore/_data:/root {IMAGE_TITLE}

Cada ENV utilizada no comando é necessária para a configuração correta do JasperReports server. Para entender melhor seu contexto, verificar entrypoint.sh e default_master.properties (obtido a partir do pacote TIB_js-jrs-cp{VERSION}_bin.zip .

## Login no JasperReports Web
1 - Utilize a URL http://${dockerHost}:8080/jasperserver
2 - Utilize as seguintes credencias: usuário:jasperadmin senha:jasperadmin

### Informações adicionais
A imagem foi adaptada para a última versão do JasperReports Server Community Edition, ou seja, a versão 8.2.0, portanto pode haver algum conflito com versões anteriores.
A mesma pode utilizar os bancos de dados do tipo Postgresql e Mysql.
