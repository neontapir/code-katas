# frozen_string_literal: true

class Game
  attr_reader :record

  def initialize
    @record = []
  end

  def roll(pins)
    @record << pins
  end

  def score
    total = 0
    roll = 0
    10.times do
      if @record[roll] == 10
        total += 10 + @record[roll+1] + @record[roll+2]
        roll += 1
      else
        total += @record[roll] + @record[roll+1]
        if @record[roll] + @record[roll+1] == 10
          total += @record[roll+2]
        end
        roll += 2
      end
    end
    total
  end
end
