#!/bin/bash
board=$1
commit_id=$2

. /tmp/dpxdt/venv/bin/activate
cd /tmp/perceptual

# Instantiate variables in our test.yaml
cp test.yaml.in test.yaml
sed -i "s/%board/$board/g" test.yaml
if [ ! -e board_desktop.png ]; then
    # Create a baseline
    dpxdt update .
fi

# Launch tests and create the next baseline
dpxdt test . 2>&1 > /tmp/dpxdt.log
dpxdt update .

# Store everything in the commit_id dir
rm -fr $commit_id
mkdir -p $commit_id/ref
cp /tmp/dpxdt.log  $commit_id/
find /tmp -name 'log.txt' -exec cat {} + > $commit_id/logs.txt

go=`grep all /tmp/dpxdt.log | sed -e 's/.*all \(.*\):\(.*\)/mkdir \1; cp \2 \1;/'`
pushd $commit_id
echo $go
bash -c "$go"
popd
cp *.png $commit_id/ref
