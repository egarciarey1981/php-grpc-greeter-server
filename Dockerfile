FROM php:8.3-cli

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Roadrunner
COPY --from=ghcr.io/roadrunner-server/roadrunner:2024.1.0 /usr/bin/rr /usr/bin/rr

# Install dependencies
RUN apt-get update && apt-get install -y \
    libcurl4 \
    libcurl4-openssl-dev \
    libpq-dev \
    libzip-dev \
    protobuf-compiler \
    protobuf-compiler-grpc \
    unzip \
    && docker-php-ext-install curl sockets zip

# Install grpc extension
RUN pecl install grpc && docker-php-ext-enable grpc

# Set working directory
WORKDIR /code

# Copy project files
COPY . .

# Install composer dependencies
RUN composer install

# Download and install protoc plugin for PHP gRPC code generation
RUN vendor/bin/rr download-protoc-binary && mv protoc-gen-php-grpc /usr/bin/protoc-gen-php-grpc
