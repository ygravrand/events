FROM python:3.4-alpine

RUN pip install -U pip

COPY . /tmp/src

WORKDIR /tmp/src

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["python", "fast_food.py"]
