FROM node:latest

RUN apt-get update && apt-get install -y && apt-get install -y vim

WORKDIR /usr/app

COPY package.json ./

RUN npm install

COPY . .

CMD ["npm", "run", "start"]