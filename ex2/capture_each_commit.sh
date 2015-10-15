#!/bin/bash

first_commit_index=$1
last_commit_index=$2

git clone https://github.com/Net-ng/kansha.git
docker build -t perceptual .
docker build -t wrapped_kansha -f kansha-Dockerfile .
rm *.png
./run_through_commits.sh $(pwd)/kansha ./install_run_and_capture.sh $first_commit_index $last_commit_index
