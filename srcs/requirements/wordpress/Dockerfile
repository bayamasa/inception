FROM debian:buster

RUN apt-get update && \
    apt-get install -y php \
    php-cgi \
    php-fpm \
    php-common \
    php-pear \ 
    php-mbstring \
    php-mysqli \
    vim \
    curl \
    wget \
    mariadb-client

# 後の操作のために、wp-cliをdownload
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html/wordpress
COPY tool/setting.sh /usr/bin/
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

ENTRYPOINT ["sh", "/usr/bin/setting.sh"]

CMD [ "php-fpm7.3", "-F" ]
