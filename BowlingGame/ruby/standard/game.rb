class Game
  def initialize
    @tries = []
  end
  
  def roll(pins)
    @tries << pins
  end
  
  def score    
    score = 0
    roll = 0
    (1..10).each do
      if strike? roll
        score += 10 + strike_bonus_for(roll)
        roll += 1
      else 
        if spare? roll
          score += 10 + spare_bonus_for(roll)
        else
          score += pins_in_frame
        end
        roll += 2
      end
    end
    
    score
  end
  
  def strike?(roll)
    @tries[roll] == 10
  end
  
  def spare?(roll)
    @tries[roll] + @tries[roll+1] == 10
  end
  
  def strike_bonus_for(roll)
    @tries[roll+1] + @tries[roll+2]
  end
  
  def spare_bonus_for(roll)
    @tries[roll+2]
  end
  
  def pins_in_frame
    @tries[roll] + @tries[roll+1]
  end
end