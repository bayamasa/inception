FROM debian:buster

RUN apt-get update && \
    apt-get install -y php \
    php-cgi \
    php-fpm \
    php-common \
    php-pear \ 
    php-mbstring \
    vim \
    curl \
RUN mkdir /run/php
ENTRYPOINT ["php-fpm7.3", "-F"]
