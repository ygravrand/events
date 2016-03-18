#!/bin/sh
EXAMPLE=ex3_aiohttp_py35

docker build -t $EXAMPLE .
docker rm $EXAMPLE
docker run -P --name=$EXAMPLE $EXAMPLE
