import requests

from src.foo import Foo


def lambda_handler(payload, context):

    print(f'Payload: {payload}')
    print(f'Context: {context}')
    print(requests.get('https://www.google.com'))
    foo = Foo()
    res = foo.do_something(1, 2)

    return res


if __name__ == '__main__':
    print(f'The result is {lambda_handler(dict(), None)}')
