import unittest

from src.bar import Bar


class TestBar(unittest.TestCase):

    def test_bar_sum_should_be_positive(self):

        bar = Bar()

        ret_val = bar.sum(3, -2)

        self.assertGreater(ret_val, 0)

    def test_bar_sum_should_be_negative(self):

        bar = Bar()

        ret_val = bar.sum(-3, -2)

        self.assertLess(ret_val, 0)

    def test_bar_sum_should_be_zero(self):

        bar = Bar()

        ret_val = bar.sum(3, -3)

        self.assertEqual(ret_val, 0)
