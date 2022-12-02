require 'rspec'

# SCORE ||= {
#   :rock => 1,
#   :paper => 2,
#   :scissors => 3,
# }

WINNERS ||= [
  [:rock, :paper],
  [:paper, :scissors],
  [:scissors, :rock]
]

# SHAPES ||= [:rock, :paper, :scissors]
OUTCOMES ||= [:lose, :draw, :win]

class NameValuePair
  attr_reader :name, :value

  def initialize(name, value)
    name = name
    value = value
  end

  def to_sym
    name
  end

  def to_s
    name.to_s
  end
end

class Shape < NameValuePair
  attr_reader :name, :value, :beats

  def initialize(name, value, outcomes)
    super(name, value)
  end

  ROCK ||= Shape.new(:rock, 1)
  PAPER ||= Shape.new(:paper, 2, )
  SCISSORS ||= Shape.new(:scissors, 3)
end

class RpsPlaybook
  def decypher(shape)
    case shape
    when 'A', 'X' then Shape::ROCK
    when 'B', 'Y' then Shape::PAPER
    when 'C', 'Z' then Shape::SCISSORS
    else raise "Bad shape #{shape}"
    end
  end

  def decode(line)
    them_code, us_code = line.split(' ')
    [decypher(them_code), decypher(us_code)]
  end

  def result(round)
    them, us = round
    if them == us
      3 # draw
    elsif WINNERS.include? round
      6 # win
    else
      0 # loss
    end
  end

  def outcome(round)
    round.last.value + result(round)
  end

  def score(rounds)
    rounds.map{|r| outcome(decode(r))}.sum
  end
end

class RpsCoersionPlan < RpsPlaybook
  def response(them, desired)

  end

  def decypher_outcome(code)
    case code
    when 'X' then :lose
    when 'Y' then :draw
    when 'Z' then :win
    end
  end

  def decode(line)
    them_code, desired_outcome_code = line.split(' ')
    them_value = decypher(them_code)
    desired = decypher_outcome(desired_outcome_code)
    [them_value, response(them_value, desired)]
  end
end