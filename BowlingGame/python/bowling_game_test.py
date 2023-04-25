from .bowling_game import Game

def test_score_no_pins_hit():
    assert Game().score() == 0

def test_score_one_when_one_pin_hit():
    game = Game()
    game.roll(1)
    assert game.score() == 1

def test_score_handles_spares():
    game = Game()
    game.roll(3)
    game.roll(7)
    game.roll(4)
    assert game.score() == 18

def test_score_handles_strikes():
    game = Game()
    game.roll(10)
    game.roll(7)
    game.roll(2)
    assert game.score() == 28

def test_perfect_game():
    game = Game()
    for i in range(12):
        game.roll(10)
    assert game.score() == 300

def test_sample_chatgpt_game():
    game = Game()
    game.roll(1)
    game.roll(4)
    game.roll(4)
    game.roll(5)
    game.roll(6)
    game.roll(4)
    game.roll(5)
    game.roll(5)
    game.roll(10)
    game.roll(0)
    game.roll(1)
    game.roll(7)
    game.roll(3)
    game.roll(6)
    game.roll(4)
    game.roll(10)
    game.roll(2)
    game.roll(8)
    game.roll(6)
    assert game.score() == 133