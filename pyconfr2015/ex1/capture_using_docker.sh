#!/bin/bash
set -e

mkdir -p out
docker build -t pyconfr2015_ex1 .
docker run -v $(pwd)/out:/tmp/out pyconfr2015_ex1 /bin/sh -c "/tmp/dpxdt/venv/bin/dpxdt update .; cp *.png /tmp/out"