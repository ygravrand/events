#!/bin/sh
EXAMPLE=ex4_gevent

docker build -t $EXAMPLE .
docker rm $EXAMPLE
docker run -P --name=$EXAMPLE $EXAMPLE
