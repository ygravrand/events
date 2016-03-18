# Encoding: utf-8
import asyncio
from aiohttp import web


@asyncio.coroutine
def kitchen_work():
    yield from asyncio.sleep(5)


@asyncio.coroutine
def fast_food_host(request):
    print('Order sent to the kitchen, waiting...', flush=True)

    yield from kitchen_work()

    print('Burger received from kitchen!', flush=True)
    return web.Response(body='Here\'s your order.'.encode('utf-8'))


app = web.Application()
app.router.add_route('GET', '/', fast_food_host)

if __name__ == '__main__':
    web.run_app(app, host='0.0.0.0', port=8000)
