require 'rspec'
require_relative '../game'

class Game_spec
  describe "A bowling game" do
    before :each do
      @game = Game.new
    end
    
    it "can score a gutter game" do
      20.times do
        @game.roll(0)
      end
      expect(@game.score).to eq(0)
    end
    
    it "can score a game of all 1's" do
      20.times do
        @game.roll(1)
      end
      expect(@game.score).to eq(20)
    end
    
    it "can score a spare" do
      @game.roll(4)
      @game.roll(6) #spare
      @game.roll(3)
      17.times do
        @game.roll(0)
      end
      expect(@game.score).to eq(16)
    end
  end
end