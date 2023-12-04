from .bar import Bar


class Foo:

    def __init__(self):
        self.bar = Bar()

    def do_something(self, num_1: int, num_2: int) -> int:
        return self.bar.sum(num_1, num_2)
