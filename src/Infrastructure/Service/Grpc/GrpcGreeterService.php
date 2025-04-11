<?php

namespace App\Infrastructure\Service\Grpc;

use GRPC\Greeter\GreeterInterface;
use GRPC\Greeter\GreeterReply;
use GRPC\Greeter\GreeterRequest;
use Spiral\RoadRunner\GRPC\ContextInterface;

class GrpcGreeterService implements GreeterInterface
{
    public function SayHello(ContextInterface $context, GreeterRequest $request): GreeterReply
    {
        return new GreeterReply([
            'message' => "Hello {$request->getName()}!",
        ]);
    }
}

