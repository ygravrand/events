#!/bin/sh
EXAMPLE=ex2_multi_process

docker build -t $EXAMPLE .
docker rm $EXAMPLE
docker run -P --name=$EXAMPLE $EXAMPLE
