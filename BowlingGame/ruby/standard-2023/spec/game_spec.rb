require 'rspec'
require_relative '../game'

describe Game do
  subject(:game) {Game.new}
  context 'gutter game' do
    it 'has a score of 0' do
      expect(game.score).to eq 0
    end
  end

  context 'single ball' do
    it 'scores 1' do
      game.roll(1)
      expect(game.score).to eq 1
    end
  end

  context 'spare' do
    it 'should double the next ball' do
      game.roll(3)
      game.roll(7)
      game.roll(4)
      expect(game.score).to eq 18
    end

    it 'should double the next ball in frame 3' do
      game.roll(0)
      game.roll(0)
      game.roll(3)
      game.roll(7)
      game.roll(4)
      expect(game.score).to eq 18
    end
  end

  context 'strike' do
    it 'should double the next 2 balls' do
      game.roll(10)
      game.roll(1)
      game.roll(2)
      expect(game.score).to eq 16
    end
  end

  context 'perfect game' do
    it 'scores 300' do
      (1..12).each do
        game.roll(10)
      end
      expect(game.score).to eq 300
    end
  end
end