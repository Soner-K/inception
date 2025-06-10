#!/bin/sh

if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Go to wordpress directory
cd /var/www/wordpress

# Wait for database connection (retry up to 30 times)
echo "Waiting for database connection..."
for i in $(seq 1 30); do
    if wp --allow-root core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" 2>/dev/null; then
        echo "Database connection successful!"
        break
    fi
    echo "Attempt $i: Database connection failed, retrying in 5 seconds..."
    sleep 5
done

# Check if wp-config.php exists
if [ -f "/var/www/wordpress/wp-config.php" ]; then
    echo "WordPress config already exists."
else
    echo "Creating WordPress config..."
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
fi

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    # Download WordPress if not already present
    if [ ! -f "/var/www/wordpress/index.php" ]; then
        wp core download --allow-root
    fi
    
    # Install WordPress
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root
fi

# Configure WordPress for HTTPS
wp config set WP_HOME "https://$DOMAIN_NAME/" --allow-root
wp config set WP_SITEURL "https://$DOMAIN_NAME/" --allow-root
wp search-replace "http://$DOMAIN_NAME/" "https://$DOMAIN_NAME/" --skip-columns=guid --all-tables --allow-root

# Set proper permissions
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress/

# Configure PHP-FPM
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F