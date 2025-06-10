WP_DATA = /home/sokaraku/data/wordpress 
DB_DATA = /home/sokaraku/data/mariadb 

all: up

up: build
	@sudo mkdir -p $(DB_DATA)
	@sudo mkdir -p $(WP_DATA)
	@sudo chmod -R 777 $(DB_DATA) # Set directory permissions first
	@sudo chown -R 999:999 $(DB_DATA) # MariaDB uses UID 999
	@sudo chown -R 33:33 $(WP_DATA) # www-data in container
	# @bash add_host.sh
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down --remove-orphans

force-down:
	sudo docker rm -f mariadb wordpress nginx || true
	sudo docker network rm inception || true

stop:
	sudo docker-compose -f ./srcs/docker-compose.yml stop

start:
	sudo docker-compose -f ./srcs/docker-compose.yml start

build:
	sudo docker-compose -f ./srcs/docker-compose.yml build

clean:
	@sudo docker-compose -f ./srcs/docker-compose.yml down || true
	@sudo docker container prune -f || true
	@sudo docker image prune -a -f || true
	@sudo docker volume prune -f || true
	@sudo docker network prune -f || true

fclean: clean force-down
	@sudo rm -rf $(WP_DATA) || true
	@sudo rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@sudo docker system prune -a --volumes -f