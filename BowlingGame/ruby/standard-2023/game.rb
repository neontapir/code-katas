class Game
  def initialize
    @rolls = []
  end

  def roll(value)
    @rolls << value
  end

  def get(index)
    @rolls[index] || 0
  end

  def spare?(index)
    get(index) + get(index + 1) == 10
  end

  def strike?(index)
    get(index) == 10
  end

  def score()
    score = 0
    i = 0
    (1..10).each do |_frame|
      score += get(i) + get(i+1)
      score += get(i+2) if(strike?(i) || spare?(i))
      i += strike?(i) ? 1 : 2
    end
    score
  end
end