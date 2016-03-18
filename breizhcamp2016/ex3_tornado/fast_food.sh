#!/bin/sh
EXAMPLE=ex3_tornado

docker build -t $EXAMPLE .
docker rm $EXAMPLE
docker run -P --name=$EXAMPLE $EXAMPLE
