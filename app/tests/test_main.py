import unittest

import mock

from main import run


class TestMain(unittest.TestCase):

    @mock.patch('main.Foo')
    def test_run(self, _foo):

        # Arrange
        _foo.return_value = foo = mock.Mock()
        foo.do_something.return_value = 3

        # Act
        ret_val = run()

        # Assert
        self.assertEqual(ret_val, 3)
