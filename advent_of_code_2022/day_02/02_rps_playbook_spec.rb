require 'rspec'
require_relative './02_rps_playbook.rb'

class RpsPlaybookSpec
  describe RpsPlaybook do
    it 'can decode a line' do
      expect(subject.decode('A Y')).to eq [Shape::ROCK, Shape::PAPER]
    end

    it 'can determine the outcome of a round' do
      expect(subject.outcome([Shape::ROCK, Shape::SCISSORS])).to eq 3
      expect(subject.outcome([Shape::SCISSORS, Shape::SCISSORS])).to eq 6
      expect(subject.outcome([Shape::PAPER, Shape::SCISSORS])).to eq 9
    end

    it 'can score a sample series of rounds' do
      expect(subject.score(File.open('day_02/day_02_sample.txt').lines)).to eq 15
    end

    it 'can score a series of rounds' do
      expect(subject.score(File.open('day_02/day_02_input.txt').lines)).to eq 9759
    end
  end
end