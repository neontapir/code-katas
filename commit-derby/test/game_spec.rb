require 'minitest/spec'
require 'minitest/autorun'
require_relative '../Game'

describe Game do
  it 'can score an empty game' do
    Game.new.score.must_equal 0
  end
end
