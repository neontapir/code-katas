# frozen_string_literal: true

require 'rspec'
require_relative '../game'

describe 'the bowling game' do
  before :each do
    @game = Game.new
  end

  it 'can score an empty game' do
    10.times do
      @game.roll 0
      @game.roll 0
    end
    expect(@game.score).to eq 0
  end

  it 'can score a simple game' do
    10.times do
      @game.roll 1
      @game.roll 1
    end
    expect(@game.score).to eq 20
  end

  it 'can score a spare' do
    @game.roll 1
    @game.roll 9
    @game.roll 2
    @game.roll 0
    8.times do
      @game.roll 0
      @game.roll 0
    end
    expect(@game.score).to eq 14
  end

  it 'can score a strike' do
    @game.roll 10
    @game.roll 3
    @game.roll 5
    8.times do
      @game.roll 0
      @game.roll 0
    end
    expect(@game.score).to eq 26
  end

  it 'can score a prefect game' do
    12.times do
      @game.roll 10
    end
    expect(@game.score).to eq 300
  end
end
