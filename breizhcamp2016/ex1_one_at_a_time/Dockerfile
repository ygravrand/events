FROM python:2.7-alpine

RUN pip install -U pip

COPY . /tmp/src

WORKDIR /tmp/src

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "fast_food.py"]
