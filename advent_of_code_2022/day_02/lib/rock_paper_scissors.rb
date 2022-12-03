class RockPaperScissors
  SHAPES = [:rock, :paper, :scissors]
  OUTCOMES = [:lose, :draw, :win]

  def wins_against(shape)
    position = SHAPES.index(shape)
    SHAPES.rotate(1)[position]
  end

  def loses_against(shape)
    position = SHAPES.index(shape)
    SHAPES.rotate(-1)[position]
  end

  def outcome(them, us)
    if them == us
      :draw
    elsif us == wins_against(them)
      :win
    elsif us == loses_against(them)
      :lose
    else
      raise 'Unexpeced outcome'
    end
  end

  def score(them, us)
    shape_score = SHAPES.index(us) + 1
    outcome_score = OUTCOMES.index(outcome(them, us)) * 3
    shape_score + outcome_score
  end

  def total(rounds)
    rounds.map{|r| score(r[0], r[1])}.sum
  end
end