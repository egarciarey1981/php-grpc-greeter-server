<?php

require __DIR__ . '/vendor/autoload.php';

use App\Infrastructure\Service\Grpc\GrpcGreeterService;
use GRPC\Greeter\GreeterInterface;
use Spiral\RoadRunner\GRPC\Invoker;
use Spiral\RoadRunner\GRPC\Server;
use Spiral\RoadRunner\Worker;

$server = new Server(new Invoker(), [
    'debug' => false, // optional (default: false)
]);

# Register the services
$server->registerService(GreeterInterface::class, new GrpcGreeterService());

# Start the server
$server->serve(Worker::create());
