require 'minitest/spec'
require 'minitest/autorun'
require_relative '../Game'

describe Game do
  it 'starts game with a 0 score' do
    Game.new.score.must_equal 0
  end
end

