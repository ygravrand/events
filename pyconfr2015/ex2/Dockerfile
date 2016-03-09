FROM ubuntu:14.04

# dpxdt dependencies
RUN apt-get update && apt-get install -y -q phantomjs python python-dev python-distribute python-pip python-virtualenv build-essential imagemagick git --no-install-recommends

# not using virtualenv leads to a bug with requests : https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991
RUN mkdir /tmp/dpxdt && \
    virtualenv /tmp/dpxdt/venv

RUN git clone https://github.com/bslatkin/dpxdt.git /tmp/dpxdt/src

COPY dpxdt.patch /tmp/dpxdt/src/
RUN cd /tmp/dpxdt/src && git apply dpxdt.patch

RUN . /tmp/dpxdt/venv/bin/activate && \
    cd /tmp/dpxdt/src && \
    pip install -r requirements.txt && \
    pip install -e .

