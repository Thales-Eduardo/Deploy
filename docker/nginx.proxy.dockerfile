FROM nginx:latest

RUN apt-get update && apt-get install -y vim

RUN rm -f /etc/nginx/nginx.conf

COPY nginx/proxy_reverso/nginx.conf /etc/nginx/

RUN rm -f /etc/nginx/conf.d/default.conf

COPY nginx/proxy_reverso/server.proxy.nginx.conf /etc/nginx/conf.d/

RUN rm -f /usr/share/nginx/html/index.html

COPY nginx/proxy_reverso/index.html /usr/share/nginx/html/