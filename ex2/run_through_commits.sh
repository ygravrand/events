#!/bin/bash
# Inspired from https://gist.github.com/zeroem/6822534
PROJECT_ROOT=$1
CAPTURE_SCRIPT=$2
first_commit_index=$3
last_commit_index=$4

git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT reset --hard
git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT clean -xdf

COMMITS=$(git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT log --oneline  --reverse | cut -d " " -f 1)
CODE=0

i=0
echo "Looping through commits... ($first_commit_index-$last_commit_index)"
for COMMIT in $COMMITS
do
    ((i = i + 1))
    if [[ "$first_commit_index" != "" && $i -lt $first_commit_index ]]; then
        continue
    fi
    if [[ "$last_commit_index" != "" &&  $i -gt $last_commit_index ]]; then
        break
    fi
    git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT checkout $COMMIT

    dir="diffs_${i}_$COMMIT"
    echo "Capturing to $dir"
    mkdir -p $dir && git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT log --oneline -n 1 > $dir/gitlog.txt
    $CAPTURE_SCRIPT $dir
    retval=$?

    if [ $retval -eq 0 ]
    then
        echo $COMMIT - passed
    else
        echo $COMMIT - failed
        exit
    fi

    git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT reset --hard
    git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT clean -xdf
    echo "Proceeding to next commit"
done

git --git-dir=$PROJECT_ROOT/.git --work-tree=$PROJECT_ROOT checkout master
