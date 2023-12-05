import unittest

import mock

from lambda_function import lambda_handler


class TestMain(unittest.TestCase):

    @mock.patch('lambda_function.Foo')
    def test_lambda_handler(self, _foo):

        # Arrange
        _foo.return_value = foo = mock.Mock()
        foo.do_something.return_value = 3

        # Act
        ret_val = lambda_handler(dict(), None)

        # Assert
        self.assertEqual(ret_val, 3)
