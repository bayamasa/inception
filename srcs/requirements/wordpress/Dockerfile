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

# wp core download --path=/var/www/html/wordpress --allow-root
# CDで--pathに移動
# wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=mariadb:3306 --allow-root --skip-check --path=/var/www/html/wordpress
# wp core install --url=http://example.com/ --title=test --admin_user=wordpress_user --admin_password=password --admin_email=test@example.com --allow-root --path=/var/www/html/wordpress

RUN mkdir -p /var/www/html/wordpress
RUN mkdir /run/php
ENTRYPOINT ["php-fpm7.3", "-F"]
