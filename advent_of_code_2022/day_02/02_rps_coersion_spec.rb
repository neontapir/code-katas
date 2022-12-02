require 'rspec'
require_relative '02_rps_playbook'

class RpsCoersionPlanSpec
  describe RpsCoersionPlan do
    it 'can determine the response needed to obtain a desired outcome' do
      skip
      expect(subject.decode('A Y')).to eq [Shape::ROCK, Shape::PAPER]
    end

    it 'can score a sample series of rounds' do
      skip
      expect(subject.score(File.open('day_02/day_02_sample.txt').lines)).to eq 12
    end

    it 'can score a series of rounds' do
      skip
      expect(subject.score(File.open('day_02/day_02_input.txt').lines)).to eq -1
    end
  end
end