
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# install the required packages
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

# copy the wordpress configuration script to the root directory in the container
COPY ./tools/wordpress_setup.sh /wordpress_setup.sh

# change the permission of the script to make it executable
RUN  chmod +x wordpress_setup.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wordpress_setup.sh"]
