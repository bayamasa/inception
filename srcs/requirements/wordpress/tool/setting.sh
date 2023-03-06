#!/bin/sh

while ! mysqladmin ping -h mariadb -u wordpress -pwordpress > /dev/null 2>&1
do
    sleep 1
done 

wp core download --path=/var/www/html/wordpress --allow-root
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=mariadb:3306 --allow-root --skip-check --path=/var/www/html/wordpress
wp core install --url=http://example.com/ --title=test --admin_user=wordpress_user --admin_password=password --admin_email=test@example.com --allow-root --path=/var/www/html/wordpress

mkdir -p /run/php

exec "$@"
