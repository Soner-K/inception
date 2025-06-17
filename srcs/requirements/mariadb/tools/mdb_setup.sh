#!/bin/bash

# Start MariaDB service
service mariadb start
sleep 5

# Create DB and user
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO \`${MYSQL_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

# Secure root access: require password
mariadb -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Shutdown and restart MariaDB properly
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
