#!/bin/sh

# データベースにアクセスできるまで確認するようにしないと落ちるかも
while ! mysqladmin ping -h mariadb -u wordpress -pwordpress > /dev/null 2>&1
do
    sleep 3
done 

if ! wp core is-installed --allow-root --path=/var/www/html &> /dev/null ; then

    echo "Installing wordpress..."
    wp core download --path=/var/www/html --allow-root
    wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=mariadb --allow-root --skip-check --path=/var/www/html --extra-php \
    

    wp core install --url=localhost:8080 --title=localhost --admin_user=wordpress_user --admin_password=password --admin_email=hello@example.com --allow-root --path=/var/www/html

    wp user create --allow-root wordpress hello@gmail.com --user_pass=wordpress --role=author --path=/var/www/html

fi

chmod -R 775 /var/www/*
chown -R www-data:www-data /var/www/*
mkdir -p /run/php/

exec "$@"
