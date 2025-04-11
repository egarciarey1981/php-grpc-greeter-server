<?php

namespace App\Infrastructure\Service\Grpc;

use Grpc\BaseStub;
use Grpc\ChannelCredentials;
use GRPC\Greeter\GreeterRequest;

class GrpcGreeterClient extends BaseStub
{
    public function __construct(string $hostname, array $opts = [], $channel = null)
    {
        parent::__construct($hostname, $opts, $channel);
    }

    public function SayHello(GreeterRequest $argument, $metadata = [], $options = [])
    {
        return $this->_simpleRequest(
            '/GRPC.Greeter.Greeter/SayHello',
            $argument,
            ['\GRPC\Greeter\GreeterReply', 'decode'],
            $metadata,
            $options
        );
    }
}
