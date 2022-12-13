require 'rspec'
require_relative 'lib/supply_stack'
require_relative 'lib/cranemover_9001'

describe SupplyStack do
  context 'part 1 sample set' do
    it 'can parse crate diagram' do
      stack = SupplyStack.new('day_05/day_05_sample.txt')
      expect(stack.state[0]).to eq ["Z","N"," "]
      expect(stack.state[1]).to eq ["M","C","D"]
      expect(stack.state[2]).to eq ["P"," "," "]
    end

    it 'can apply a move' do
      stack = SupplyStack.new('day_05/day_05_sample.txt')
      move = "move 1 from 2 to 1"
      stack.transform(move)
      expect(stack.state).to eq [["Z","N","D"], ["M","C"," "], ["P"," "," "]]
    end

    it 'can apply multiple moves' do
      stack = SupplyStack.new('day_05/day_05_sample.txt')
      stack.rearrange
      expect(stack.state).to eq [["C", " ", " ", " "], ["M", " ", " ", " "], ["P", "D", "N", "Z"]]
    end

    it 'can find the top crate in each stack' do
      stack = SupplyStack.new('day_05/day_05_sample.txt')
      stack.rearrange
      expect(stack.top_crates).to eq "CMZ"
    end
  end

  context 'part 1 input set' do
    it 'can find the top crate in each stack' do
      stack = SupplyStack.new('day_05/day_05_input.txt')
      stack.rearrange
      expect(stack.top_crates).to eq "TQRFCBSJJ"
    end
  end

  context 'part 2 input set' do
    it 'can find the top crate in each stack' do
      stack = SupplyStack.new('day_05/day_05_input.txt', CraneMover9001.new)
      stack.rearrange
      expect(stack.top_crates).to eq "RMHFJNVFP"
    end
  end
end