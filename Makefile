WP_DATA = /home/data/wordpress 
DB_DATA = /home/data/mariadb 

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./docker-compose.yml up -d

down:
	docker-compose -f ./docker-compose.yml down

stop:
	docker-compose -f ./docker-compose.yml stop

start:
	docker-compose -f ./docker-compose.yml start

build:
	docker-compose -f ./docker-compose.yml build

clean:
	@docker-compose -f ./docker-compose.yml down || true
	@docker container prune -f || true
	@docker image prune -a -f || true
	@docker volume prune -f || true
	@docker network prune -f || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f