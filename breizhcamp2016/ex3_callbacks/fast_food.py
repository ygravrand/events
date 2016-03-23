# Encoding: utf-8
import sys
from twisted.web import server, resource
from twisted.internet import reactor
from twisted.internet.task import deferLater


def kitchen_work(get_result):
    return deferLater(reactor, 5, get_result)


class FastFoodResource(resource.Resource):

    isLeaf = True

    def on_burger_ready(self, request):
        print 'Burger received from kitchen!'
        sys.stdout.flush()
        request.setHeader("content-type", "text/plain")
        request.write('Here\'s your order.')
        request.finish()

    def render_GET(self, request):
        print 'Order sent to the kitchen, waiting...'
        sys.stdout.flush()

        deferred = kitchen_work(lambda: request)
        deferred.addCallback(self.on_burger_ready)
        
        return server.NOT_DONE_YET


if __name__ == "__main__":
    reactor.listenTCP(5000, server.Site(FastFoodResource()))
    reactor.run()
