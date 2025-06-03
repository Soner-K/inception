FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y mariadb-server netcat

# copy file from host to container
COPY ./tools/on_launch_exec.sh /on_launch_exec.sh

# set permissions to the file
RUN chmod +x /on_launch_exec.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./on_launch_exec.sh"]