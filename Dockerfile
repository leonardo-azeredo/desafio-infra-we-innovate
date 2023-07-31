#usa a imagem base
FROM node:18-alpine 

#define o diretório padrão de trabalho
WORKDIR /app/src

#executa a copia dos arquivos da raiz contendo o código para dentro do diretorio /app dentro do container
COPY desafio-infra-pleno-2 /app

#acessa o diretorio /app/ e instala as dependencias do package
RUN cd /app/ && npm install

#roda o servidor
CMD ["npm" , "start"]
