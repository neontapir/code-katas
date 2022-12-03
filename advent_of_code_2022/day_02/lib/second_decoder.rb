require_relative 'rock_paper_scissors'

class SecondDecoder
  def initialize(rps_provider = RockPaperScissors.new)
    @rps_provider = rps_provider
  end

  def to_shape(code)
    case code
    when 'A' then :rock
    when 'B' then :paper
    when 'C' then :scissors
    end
  end

  def to_outcome(code)
    case code
    when 'X' then :lose
    when 'Y' then :draw
    when 'Z' then :win
    end
  end

  def desired_shape(them, outcome_code)
    desired_outcome = to_outcome(outcome_code)
    case desired_outcome
    when :draw then them
    when :win  then @rps_provider.wins_against(them)
    when :lose then @rps_provider.loses_against(them)
    end
  end

  def decode(encoded_round)
    them_code, desired_outcome_code = encoded_round.split(' ')
    them = to_shape(them_code)
    [them, desired_shape(them, desired_outcome_code)]
  end
end