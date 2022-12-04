require 'rspec'

require_relative('lib/rucksack.rb')
require_relative('lib/rucksack_set.rb')

class RucksackSpec
  describe Rucksack do
    context 'sample rucksack' do
      subject(:sample) { Rucksack.new("vJrwpWtwJgWrhcsFMMfFFhFp") }

      it 'can divide a rucksack into two equal compartments' do
        expect(sample.compartments).to eq ["vJrwpWtwJgWr".chars,"hcsFMMfFFhFp".chars]
      end

      it 'can find common elements in both compartments' do
        expect(sample.in_both_compartments).to eq ["p"]
      end

      it 'can determine the priority of an item' do
        expect(Rucksack.priority('p')).to eq 16
        expect(sample.priorities_sum).to eq 16
      end
    end

    context 'second sample rucksack' do
      subject(:sample) { Rucksack.new("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL") }

      it 'can find common elements in both compartments' do
        expect(sample.in_both_compartments).to eq ["L"]
      end

      it 'can determine the priority of an item' do
        expect(Rucksack.priority('L')).to eq 38
      end
    end

    context 'part 1 sample set' do
      subject(:rucksacks) { RucksackSet.new(File.readlines("day_03/day_03_sample.txt")) }

      it 'hydrates each rucksack correctly' do
        expect(rucksacks.first).to eq Rucksack.new("vJrwpWtwJgWrhcsFMMfFFhFp")
      end

      it 'can determine the priorities of each rucksack' do
        expect(rucksacks.map{|r| r.in_both_compartments}).to eq [["p"], ["L"], ["P"], ["v"], ["t"], ["s"]]
        expect(rucksacks.map{|r| r.priorities_sum}).to eq [16, 38, 42, 22, 20, 19]
      end

      it 'can determine the sum of priorities of a group' do
        expect(rucksacks.priorities_total).to eq 157
      end
    end

    context 'part 2 sample set' do
      subject(:first_group) { ["vJrwpWtwJgWrhcsFMMfFFhFp",
        "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
        "PmmdzqPrVvPwwTWBwg"] }

      subject(:second_group) { ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
        "ttgJtRGJQctTZtZT",
        "CrZsJsPPZsGzwwsLwLmpwMDw"] }
        
      it 'can find common elements in all rucksacks' do
        expect(RucksackSet.new(first_group).in_all_rucksacks).to eq ['r']
        expect(RucksackSet.new(second_group).in_all_rucksacks).to eq ['Z']
      end

      it 'can split a set into triads' do
        combined = first_group + second_group
        actual = RucksackSet.new(combined).into_triads
        expect(actual.first).to eq RucksackSet.new(first_group)
        expect(actual.last).to eq RucksackSet.new(second_group)
      end
    end

    context 'input' do
      subject(:rucksacks) { RucksackSet.new(File.readlines("day_03/day_03_input.txt")) }

      it 'can determine the sum of priorities of a group' do
        expect(rucksacks.priorities_total).to eq 8240
      end

      it 'can determine the sum of priorities of item types' do
        actual = rucksacks.into_triads.map{|t| t.badge_priority}.sum
        expect(actual).to eq 2587
      end
    end
  end
end