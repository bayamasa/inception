FROM debian:buster

RUN apt-get update && \
    apt-get install -y wget \
    gnupg \
    vim

RUN wget https://nginx.org/keys/nginx_signing.key
RUN apt-key add nginx_signing.key
RUN touch /etc/apt/sources.list.d/nginx.list
RUN echo deb https://nginx.org/packages/mainline/debian/ buster nginx \
    >> /etc/apt/sources.list.d/nginx.list
RUN echo deb-src https://nginx.org/packages/mainline/debian/ buster nginx \
    >> /etc/apt/sources.list.d/nginx.list

RUN apt-get update && \
    apt-get install -y nginx \
    openssl \ 
    procps \
    libfcgi0ldbl

COPY conf/nginx.conf /etc/nginx/
COPY conf/default.conf /etc/nginx/conf.d/

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
