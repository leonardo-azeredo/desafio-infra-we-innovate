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

    version: '3.8'
    
    services:
      app:
        build:
          context: .
          dockerfile: Dockerfile
        ports:
          - "80:80"
      nginx:
        image: nginx:latest
        volumes:
          - ./nginx.conf:/etc/nginx/nginx.conf:ro
        depends_on:
          - app

Para executar o projeto
-----------------------

Siga os passos abaixo para executar o projeto:

1.  Certifique-se de que o Docker e o Docker Compose estejam instalados em sua máquina.
2.  Clone o repositório.
3.  Abra um terminal na pasta do projeto, onde estão os arquivos do repositório clonado. 
4.  Digite o seguinte comando para construir e iniciar os containers:

```
 docker-compose up
