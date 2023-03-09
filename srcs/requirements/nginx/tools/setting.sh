#!/bin/bash

mkdir -p /etc/nginx/ssl

openssl genrsa -out /etc/nginx/ssl/server.key 2048
openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=Roppongi/O=42Tokyo/OU=Student/CN=mhirabay"
openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt


