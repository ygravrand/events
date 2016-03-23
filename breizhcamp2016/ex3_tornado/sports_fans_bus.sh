#!/bin/bash

function get_host_and_port() {
    DOCKER_CONTAINER=$1
    PORT_IN_CONTAINER=$2
    docker-machine 1> /dev/null 2> /dev/null
    if [ $? == 0 ]; then
        DOCKER_MACHINE_ACTIVE=`docker-machine active`
        HOST=`docker-machine ip $DOCKER_MACHINE_ACTIVE`
    else
        HOST='localhost'
    fi
    PORT=`docker inspect --format="{{(index (index .NetworkSettings.Ports \"$PORT_IN_CONTAINER/tcp\") 0).HostPort}}" $DOCKER_CONTAINER`
    RES=$HOST:$PORT
    echo $RES
}

HOST_AND_PORT=$(get_host_and_port 'ex3_tornado' 5000)
echo $HOST_AND_PORT
ab -n 50 -c 50 http://$HOST_AND_PORT/
