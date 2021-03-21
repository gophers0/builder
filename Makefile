clean:
	rm -rf ./main
	rm -rf ./users
	rm -rf ./storage

get_main:
	git clone git@github.com:gophers0/main.git
	git clone git@github.com:gophers0/users.git
	git clone git@github.com:gophers0/storage.git
	cp config_users_local.json ./users/config_local.json
	cp users/.env.example users/.env
	cp storage/.env.example storage/.env
	cp config_storage_local.json ./storage/config_local.json

run: clean get_main build
	docker-compose up -d && docker logs -f storage_app

build: docker-down
	docker-compose build

docker-down:
	docker-compose down

deploy:
	rsync -avzhe ssh . hack:/srv/users/
