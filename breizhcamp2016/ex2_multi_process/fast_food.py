# Encoding: utf-8
import sys
import time
from flask import Flask


app = Flask(__name__)


def kitchen_work():
    time.sleep(5)


@app.route('/')
def fast_food_host():
    print 'Order sent to the kitchen, waiting...'
    sys.stdout.flush()

    kitchen_work()

    print 'Burger received from kitchen!'
    sys.stdout.flush()
    return 'Here\'s your order.'


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
