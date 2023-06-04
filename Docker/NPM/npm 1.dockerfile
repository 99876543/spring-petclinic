FROM node:latest
WORKDIR /app

RUN apt update && apt install git npm -y

RUN git clone https://github.com/Azure-Samples/js-e2e-express-server.git && \
    cd js-e2e-express-server
WORKDIR /app/js-e2e-express-server

RUN npm install 

RUN npm run

EXPOSE 3000

CMD ["npm", "start"]


