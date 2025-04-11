<?php

use App\Infrastructure\Service\Grpc\GrpcGreeterClient;
use GRPC\Greeter\GreeterRequest;

require __DIR__ . '/vendor/autoload.php';


$hostname = 'localhost:9001';
$options = [
    'credentials' => \Grpc\ChannelCredentials::createInsecure()
];

$client = new GrpcGreeterClient($hostname, $options);

$request = new GreeterRequest();
$request->setName("Eliecer");

$call = $client->SayHello($request);

list($response, $status) = $call->wait();

if ($status->code !== 0) {
    echo 'Error: ' . $status->details;
    exit;
}

echo $response->getMessage() . PHP_EOL;
