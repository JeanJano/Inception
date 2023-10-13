#!/bin/bash

service mariadb start;

sleep 1

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root shutdown

mysqld_safe --bind-address=0.0.0.0

echo "mariaDB were create successfully!!"