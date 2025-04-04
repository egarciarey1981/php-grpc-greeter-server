FROM php:cli

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Roadrunner
COPY --from=ghcr.io/roadrunner-server/roadrunner:2024.1.0 /usr/bin/rr /usr/bin/rr

# Install dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libcurl4 \
    libpq-dev \
    libzip-dev \
    unzip \
    protobuf-compiler \
    protobuf-compiler-grpc \
    && docker-php-ext-install curl zip sockets

# Set working directory
WORKDIR /code

# Copy project files
COPY . .

# Install composer dependencies
RUN composer install

# Install protoc
RUN vendor/bin/rr download-protoc-binary

# Start Roadrunner
CMD ["rr", "start"]

