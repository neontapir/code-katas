require 'rspec'
require_relative 'lib/file_parser'
require_relative 'lib/first_decoder'
require_relative 'lib/second_decoder'

describe RockPaperScissors do
  it 'calculates the outcomes of a round' do
    expect(subject.outcome(:rock, :rock)).to eq :draw
    expect(subject.outcome(:rock, :paper)).to eq :win
    expect(subject.outcome(:paper, :scissors)).to eq :win
    expect(subject.outcome(:scissors, :rock)).to eq :win
    expect(subject.outcome(:rock, :scissors)).to eq :lose
  end

  it 'scores a round' do
    expect(subject.score(:rock, :paper)).to eq 8
  end

  it 'scores a set of rounds' do
    expect(subject.total([[:rock, :paper], [:rock, :paper]])).to eq 16
  end
end

describe FirstDecoder do
  it 'decodes a line correctly' do
    expect(subject.decode('A Y')).to eq [:rock, :paper]
  end
end

describe FileParser do
  it 'parses a sample encoded file correctly' do
    expect(subject.to_total('day_02/day_02_sample.txt', FirstDecoder)).to eq 15
  end

  it 'parses the input with the first decoder correctly' do
    expect(subject.to_total('day_02/day_02_input.txt', FirstDecoder)).to eq 9759
  end

  it 'parses the sample with the second decoder correctly' do
    expect(subject.to_total('day_02/day_02_sample.txt', SecondDecoder)).to eq 12
  end

  it 'parses the input with the second decoder correctly' do
    expect(subject.to_total('day_02/day_02_input.txt', SecondDecoder)).to eq 12429
  end
end