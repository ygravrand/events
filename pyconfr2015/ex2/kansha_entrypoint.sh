#!/bin/sh
set -e

cd /tmp/kansha
rm -f kansha.ready
/opt/stackless/bin/easy_install -m .
/opt/stackless/bin/python setup.py develop
/opt/stackless/bin/python setup.py compile_catalog
/opt/stackless/bin/nagare-admin drop-db kansha || true
/opt/stackless/bin/nagare-admin create-db kansha
/opt/stackless/bin/nagare-admin create-index kansha || true
touch kansha.ready
/opt/stackless/bin/nagare-admin serve kansha --host=0.0.0.0