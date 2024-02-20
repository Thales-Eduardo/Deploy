git clone https://github.com/Thales-Eduardo/nginx.git app && cd app

sudo apt install apt-transport-https ca-certificates curl software-properties-common \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io \
 && sudo usermod -aG docker $USER
 && docker --version

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
 && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && source ~/.bashrc \
 && nvm --version && nvm install 20.9.0 && node -v && npm i -g yarn && sudo apt update 
 
yarn && yarn tsc

sudo docker-compose up -d

sudo docker logs node1 && sudo docker logs node2 && sudo docker logs nginx-proxy
