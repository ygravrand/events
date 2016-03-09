#!/bin/bash
set -e

mkdir -p out
docker build -t apero_devops_032016 .
docker run -v $(pwd)/out:/tmp/out apero_devops_032016 /bin/sh -c "/tmp/dpxdt/venv/bin/dpxdt update .; cp *.png /tmp/out"
