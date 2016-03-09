#!/bin/bash

first_commit_index=${1:-2} # Start by default at commit #2 which is a nicer start
last_commit_index=$2

rm -fr kansha *.png
git clone https://github.com/Net-ng/kansha.git
docker build -t perceptual .
docker build -t wrapped_kansha -f kansha-Dockerfile .
./run_through_commits.sh $(pwd)/kansha ./install_run_and_capture.sh $first_commit_index $last_commit_index
