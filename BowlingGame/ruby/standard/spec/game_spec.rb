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
      roll_spare
      @game.roll(3)
      17.times do
        @game.roll(0)
      end
      expect(@game.score).to eq(16)
    end
    
    it "can score a strike" do
      roll_strike
      @game.roll(6)
      @game.roll(3)
      17.times do
        @game.roll(0)
      end
      expect(@game.score).to eq(28)
    end
    
    it "can score a perfect game" do
      12.times do    
        roll_strike
      end
          
      expect(@game.score).to eq(300)
    end
    
    def roll_spare
      @game.roll(4)
      @game.roll(6) #spare
    end
    
    def roll_strike
      @game.roll(10)
    end
  end
end