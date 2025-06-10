# Description: MariaDB Dockerfile

# pull base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y mariadb-server netcat
 
# copy file from host to container
COPY ./tools/mdb_setup.sh /mdb_setup.sh

# set permissions to the file
RUN chmod +x /mdb_setup.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mdb_setup.sh"]