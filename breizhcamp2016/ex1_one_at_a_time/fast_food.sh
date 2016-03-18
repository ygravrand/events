#!/bin/sh
EXAMPLE=ex1_one_at_a_time

docker build -t $EXAMPLE .
docker rm $EXAMPLE
docker run -P --name=$EXAMPLE $EXAMPLE
