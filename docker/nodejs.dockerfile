FROM node:latest

# Instale as dependências necessárias
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 && apt-get install -y vim

# Adicione a chave GPG do repositório Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-keyring.gpg

# Adicione o repositório Yarn ao sistema
RUN echo "deb [signed-by=/usr/share/keyrings/yarn-keyring.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list > /dev/null

# Atualize a lista de pacotes e instale o Yarn
RUN apt-get update && apt-get install -y yarn

WORKDIR /usr/app

COPY package.json ./

RUN yarn

COPY . .

CMD ["yarn", "start"]