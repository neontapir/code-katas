class Array
  def sum
    self.reduce(0, :+)
  end
end

class Game
  def initialize
    @tries = []
  end
  
  def roll(pins)
    @tries << pins
  end
  
  def score
    score = @tries.sum
    
    frames = @tries.each_slice(2).to_enum
    loop do
      f = frames.next
      if f.sum == 10
        spare_pin = frames.peek.first
        score += spare_pin
     end
    end
    
    score
  end
end