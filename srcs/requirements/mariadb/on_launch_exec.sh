#!/bin/bash

mysql_secure_installation << EOF
y
y
y
y
EOF


# Need to use backtis escaped for sql identifiers (database here)
# And single quotes for string values
mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;

CREATE USER IF NOT EXISTS '${WP_ADMIN_NAME}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${WP_ADMIN_NAME}'@'%' WITH GRANT OPTION;

CREATE USER IF NOT EXISTS '${WP_OTHER_USER}'@'%' IDENTIFIED BY '${WP_OTHER_USER_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON \`${DATABASE_NAME}\`.* TO '${WP_OTHER_USER}'@'%';

FLUSH PRIVILEGES;
EOF