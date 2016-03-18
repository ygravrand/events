# Encoding: utf-8
import sys
from tornado import gen
from tornado.web import Application, RequestHandler
from tornado.ioloop import IOLoop


@gen.coroutine
def kitchen_work():
    yield gen.sleep(5)


class FastFoodHost(RequestHandler):

    @gen.coroutine
    def get(self):
        print 'Order sent to the kitchen, waiting...'
        sys.stdout.flush()

        yield kitchen_work()

        print 'Burger received from kitchen!'
        sys.stdout.flush()
        self.write('Here\'s your order.')


if __name__ == "__main__":
    application = Application([
        (r"/", FastFoodHost),
    ])
    application.listen(5000)
    IOLoop.current().start()
