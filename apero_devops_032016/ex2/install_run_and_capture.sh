#!/bin/bash
set -e

commit_id=$1
if [ "$commit_id" == "" ]; then
    echo "Usage: $0 <commit_id>"
    exit 1
fi

# Start app to capture & wait
docker stop wrapped_kansha || true
docker rm wrapped_kansha || true
container_id=`docker run -d -P --name wrapped_kansha -v $(pwd)/kansha:/tmp/kansha -v $(pwd):/tmp/perceptual wrapped_kansha`

waiting=true
while $waiting; do
    echo "Waiting for container..."
    waiting=false
    sleep 5
    docker ps | grep wrapped_kansha > /dev/null || exit 1
    docker exec wrapped_kansha ls /tmp/kansha/kansha.ready 2> /dev/null || waiting=true
done

# Extract boards
boards=`docker exec wrapped_kansha sh -c "/opt/stackless/bin/nagare-admin batch kansha /tmp/perceptual/get_boards.py" | grep board | sed -e 's/board = \(.*\)/\1/'`
echo "Found boards: $boards"

# Do the actual capture
for board in $boards; do
    docker rm perceptual || true
    docker run --name perceptual --link wrapped_kansha:kansha -v $(pwd):/tmp/perceptual perceptual /bin/bash -c "/tmp/perceptual/in_perceptual_container.sh $board $commit_id"
done

# Stop and remove app container
docker stop wrapped_kansha || true
docker rm wrapped_kansha || true