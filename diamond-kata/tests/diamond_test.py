from pytest import raises
from src.diamond import Diamond

# https://claysnow.co.uk/recycling-tests-in-tdd/

# Given a letter, print a diamond starting with ‘A’ with the supplied letter at the widest point.

# For example: print-diamond ‘C’ prints

#   A
#  B B
# C   C
#  B B
#   A


def test_non_letter():
    with raises(ValueError) as e_info:
        d = Diamond("3")


def test_lowercase():
    with raises(ValueError) as e_info:
        d = Diamond("y")


def test_A():
    d = Diamond("A")
    assert d.diamond_array == ["A"]


def test_diamond_print(capsys):
    diamond = Diamond("A")
    diamond.print()

    captured = capsys.readouterr()
    assert captured.out == "A\n"


def test_B():
    d = Diamond("B")
    assert d.diamond_array == [" A ", "B B", " A "]


def test_C():
    d = Diamond("C")
    assert d.diamond_array == ["  A  ", " B B ", "C   C", " B B ", "  A  "]


def test_E():
    d = Diamond("E")
    assert d.diamond_array == [
        "    A    ",
        "   B B   ",
        "  C   C  ",
        " D     D ",
        "E       E",
        " D     D ",
        "  C   C  ",
        "   B B   ",
        "    A    ",
    ]
