class Array
  def sum
    self.reduce(0) { |sum, x| sum += x || 0 }
  end
end

class Game
  def initialize
    @tries = []
  end
  
  def roll(pins)
    @tries << pins
    @tries << nil if pins == 10
  end
  
  def score
    score = @tries.sum
    
    frames = @tries.each_slice(2).to_enum
    #p frames
    loop do
      f = frames.next
      if f.first == 10
        strike_bonus = frames.peek.sum
        #p "Strike bonus: #{frames.peek}"
        score += strike_bonus
      elsif f.sum == 10
        spare_bonus = frames.peek.first
        score += spare_bonus
      end
    end
    
    score
  end
end