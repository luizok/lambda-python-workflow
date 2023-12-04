import unittest

import mock

from src.foo import Foo


class TestFoo(unittest.TestCase):

    @mock.patch('src.foo.Bar')
    def test_foo(self, _bar):

        # Arrange
        _bar.return_value = bar = mock.Mock()
        bar.sum.return_value = 2

        # Act
        foo = Foo()
        ret_val = foo.do_something(4, -2)

        # Assert
        self.assertEqual(ret_val, 2)
        bar.sum.assert_called_once_with(4, -2)
