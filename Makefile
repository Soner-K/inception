WP_DATA = /home/sokaraku/data/wordpress
DB_DATA = /home/sokaraku/data/mariadb

all: up

check_vm_setup:
	@if [ ! -f installation.done ]; then \
		echo "Running VM setup script..."; \
		sudo bash vm-setup.sh; \
	else \
		echo "VM already set up. Skipping setup."; \
	fi

up: check_vm_setup build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

build: check_vm_setup
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f