require 'rspec'
require_relative '../game'

class Game_spec
  describe "A bowling game" do
    it "can score a gutter game" do
      game = Game.new
      expect(game.score).to eq(0)
    end
  end
end