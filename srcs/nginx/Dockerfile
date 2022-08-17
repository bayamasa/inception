FROM debian:buster

RUN apt-get update && apt-get -y install nginx

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
