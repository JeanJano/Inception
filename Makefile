all:
	sudo mkdir -p /home/jsauvage/data/mariadb
	sudo mkdir -p /home/jsauvage/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception

fclean: clean
	@sudo rm -rf /home/jsauvage/data/*
	@docker system prune -af

re: fclean all

.Phony: all logs clean fclean