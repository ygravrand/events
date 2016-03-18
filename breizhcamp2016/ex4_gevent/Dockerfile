FROM python:2.7-alpine

RUN pip install -U pip

RUN apk update && \
    apk add build-base

COPY . /tmp/src

WORKDIR /tmp/src

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["/usr/local/bin/gunicorn", "-w", "4", "-k", "gevent", "-b", "0.0.0.0", "fast_food:app"]
