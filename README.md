DESAFIO-INFRA-PLENO-WE-INNOVATE
===============================

Este é um projeto de infraestrutura que conta com três arquivos principais: Dockerfile, nginx.conf e docker-compose.yml.

Dockerfile
----------

O Dockerfile irá buildar uma imagem personalizada utilizando uma imagem de um container com Node rodando no Alpine com o código NodeJS fornecido.

nginx.conf
----------

O nginx.conf será utilizado para configuração do Nginx para que ele funcione como proxy no docker-compose. O comando está criando um volume que mapeia o arquivo de configuração do Nginx do host para o contêiner, permitindo que o Nginx utilize essa configuração. Além disso, o volume é configurado como somente leitura para evitar modificações acidentais no contêiner.

Poderia ser utilizado mais um Dockerfile para configuração do container do nginx, porém optei pela operação utilizando o volume pela praticidade. Caso fosse utilizado seria necessário criar o Dockerfile com as seguintes opções:

    FROM nginx:latest
    # Copia o arquivo de configuração do host para o contêiner
    COPY nginx.conf /etc/nginx/nginx.conf

docker-compose.yml
------------------

O docker-compose.yml será para subir todos os containers juntos, na mesma rede, buildando o container da aplicação e expondo a porta 80 do container do proxy.

Segue abaixo o conteúdo do arquivo docker-compose.yml:

````
version: '3'

services:
  mongo_server:
    image: mongo:6.0.8
    container_name: mongo_serverContainer
    networks:
      - weinnovate-net
    environment:
      MONGO_INITDB_ROOT_USERNAME: weinnovate
      MONGO_INITDB_ROOT_PASSWORD: weinnovate

  app_server:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: Container02
    networks:
      - weinnovate-net
    depends_on:
      - mongo_server

  proxy_server:
    image: nginx:1.25.1
    container_name: Container03-proxy_serverContainer
    networks:
      - weinnovate-net
    ports:
      - "80:80"
    depends_on:
      - app_server
      - mongo_server
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro

networks:
  weinnovate-net:
````
Para executar o projeto
-----------------------

Siga os passos abaixo para executar o projeto:

1.  Certifique-se de que o Docker e o Docker Compose estejam instalados em sua máquina.
2.  Clone o repositório.
3.  Abra um terminal na pasta do projeto, onde estão os arquivos do repositório clonado. 
4.  Digite o seguinte comando para construir e iniciar os containers:

```
 docker-compose up
