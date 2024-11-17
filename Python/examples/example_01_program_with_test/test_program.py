#!/usr/bin/env python3


import unittest
from program import check_parity

class TestParity(unittest.TestCase):
    def test_odd_number(self):
        self.assertEqual(check_parity(3), "odd")

    def test_even_number(self):
        self.assertEqual(check_parity(4), "even")

    def test_zero(self):
        self.assertEqual(check_parity(0), "even")

    def test_negative_odd_number(self):
        self.assertEqual(check_parity(-3), "odd")

    def test_negative_even_number(self):
        self.assertEqual(check_parity(-4), "even")

if __name__ == '__main__':
    unittest.main()
