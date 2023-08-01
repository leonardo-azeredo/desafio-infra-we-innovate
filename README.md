DESAFIO-INFRA-PLENO-WE-INNOVATE
===============================

Esta versão 2.0 é exatamete igual a primeira, porém builda a imagem do Nginx com o .conf desejado, excluindo assim a necessidade de um volume compartilhado.


#ALTERAÇÃO REALIZADA DO DOCKER COMPOSE 

```
proxy_server:
    build:
      context: .
      dockerfile: Dockerfilenginx
    container_name: Container03-proxy_serverContainer
    networks:
      - weinnovate-net
    ports:
      - "80:80"
    depends_on:
      - app_server
      - mongo_server


