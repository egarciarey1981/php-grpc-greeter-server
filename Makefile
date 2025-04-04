PWD=$(shell pwd)
UID=$(shell id -u)
GID=$(shell id -g)

up:
	docker compose up

up-build:
	docker compose up --build

down:
	docker compose down

composer-install:
	docker run --rm -it -u $(UID):$(GID) -v $(PWD):/app composer install --ignore-platform-req=ext-sockets

protoc-generate:
	docker compose exec -u $(UID):$(GID) -w /code grpc-service protoc \
		--php_out=./generated \
		--php-grpc_out=./generated \
		$(shell find proto -name "*.proto")