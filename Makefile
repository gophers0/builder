clean:
	rm -rf ./main
	rm -rf ./users
	rm -rf ./storage

get_main:
	git clone git@github.com:gophers0/main.git
	git clone git@github.com:gophers0/users.git
	git clone git@github.com:gophers0/storage.git
	cp config_local.json ./users/config_local.json
	cp users/.env.example users/.env

run: clean get_main build
	docker-compose up -d && docker logs -f users_app

build: docker-down
	docker-compose build

docker-down:
	docker-compose down

deploy:
	rsync -avzhe ssh . hack:/srv/users/
