#!/bin/sh

service mariadb start
sleep 5

# Need to use backtis escaped for sql identifiers (database here)
# And single quotes for string values
mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
EOF

#--------------mariadb restart--------------#
# Shutdown mariadb to restart with new config
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new config in the background to keep the container running
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'