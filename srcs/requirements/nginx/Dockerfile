
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y nginx openssl

# create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# generate the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=sokaraku.42.fr/UID=bigboss"

# copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/prepare_nginx_env.sh /prepare_nginx_env.sh

# create the wordpress directory
RUN mkdir -p /var/www/wordpress

# change the owner of the wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/wordpress

RUN chmod +x prepare_nginx_env.sh && bash prepare_nginx_env.sh

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]