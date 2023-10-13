FROM node:alpine

WORKDIR /usr/app

# RUN apt-get update && apt-get install -y vim

COPY package.json ./

RUN npm install

COPY . .

CMD ["npm", "run", "start"]