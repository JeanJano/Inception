#!/bin/bash

if [ ! -d "/run/php" ]
then
        mkdir -p /run/php
fi

sleep 8

if [ -f "/var/www/html/wordpress/wp-config.php" ]
then
        echo "wordpress already download"
else

wp core download --allow-root --path="/var/www/html/wordpress/"

chmod -R 777 /var/www/html/wordpress/wp-content

wp config create --allow-root \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=${SQL_HOST};

wp core install --allow-root \
        --url=https://${DOMAIN_NAME} \
        --title=${SITE_TITLE} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL};

wp user create --allow-root \
        ${ADMIN_USER} ${ADMIN_EMAIL} \
        --role=author \
        --user_pass=${ADMIN_PASSWORD};

fi
exec /usr/sbin/php-fpm7.4 -F