PWD=$(shell pwd)
UID=$(shell id -u)
GID=$(shell id -g)

up: composer-install
	docker compose up

build-up: composer-install
	docker compose up --build

down:
	docker compose down

composer-install:
	docker run --rm -it -u $(UID):$(GID) -v $(PWD):/app composer install --ignore-platform-req=ext-sockets

protoc-generate:
	docker compose exec -u $(UID):$(GID) -w /code grpc-service protoc \
		--php_out=./generated \
		--php-grpc_out=./generated \
		--proto_path=./proto \
		--plugin=protoc-gen-grpc=/usr/bin/protoc-gen-php-grpc \
		$(shell find proto -name "*.proto")