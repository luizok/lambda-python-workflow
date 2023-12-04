from src.foo import Foo


def run():

    foo = Foo()
    res = foo.do_something(1, 2)

    return res


if __name__ == '__main__':
    print(f'The result is {run()}')
