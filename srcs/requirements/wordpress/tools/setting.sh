#!/bin/sh

# データベースにアクセスできるまで確認するようにしないと落ちるかも
while ! mysqladmin ping -h $DB_HOST -u $DB_NAME -p$DB_PASSWORD > /dev/null 2>&1
do
    sleep 3
done 

WP_OPT="--path=$WORDPRESS_FILES_PATH --allow-root"


if ! wp core is-installed $WP_OPT > /dev/null 2>&1 ; then

    echo "Installing wordpress..."
    wp core download $WP_OPT
    wp config create --dbname=$DB_NAME \
                     --dbuser=$DB_USER \
                     --dbpass=$DB_PASS \
                     --dbhost=$DB_HOST \
                     $WP_OPT --skip-check 

    wp core install --url=$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASS \
                    --admin_email=$WP_ADMIN_EMAIL \
                    $WP_OPT
    
    
    wp user create  $WP_USER \
                    $WP_EMAIL \
                    --user_pass=$WP_PASS \
                    --role=author \
                    $WP_OPT
fi


chmod -R 775 /var/www/*
chown -R www-data:www-data /var/www/*
mkdir -p /run/php/

exec "$@"
