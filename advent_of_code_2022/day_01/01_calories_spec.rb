require 'rspec'
require_relative 'lib/calories'

# NOTE: the "expected" values were all obtained by running the test with a bogus value and harvesting the actual result
describe Calories do
  it 'gets a sample list' do
    expected = ["1000", "2000", "3000", "", "4000", "", "5000", "6000", "", "7000", "8000", "9000", "", "10000"]
    expect(File.open('day_01/01_calories_sample.txt').each_line.map(&:chomp).to_a).to eq(expected)
  end

  it 'slices a sample list' do
    parsed = ["1000", "2000", "3000", "", "4000", "", "5000", "6000", "", "7000", "8000", "9000", "", "10000"]
    expected = [["1000", "2000", "3000"], ["", "4000"], ["", "5000", "6000"], ["", "7000", "8000", "9000"], ["", "10000"]]
    expect(parsed.slice_when{|i,j| j == ''}.to_a).to eq(expected)
  end

  it 'maps the sliced list to integers' do
    parsed = [["1000", "2000", "3000"], ["", "4000"], ["", "5000", "6000"], ["", "7000", "8000", "9000"], ["", "10000"]]
    expected = [[1000, 2000, 3000], [0, 4000], [0, 5000, 6000], [0, 7000, 8000, 9000], [0, 10000]]
    expect(parsed.map{|i| i.map(&:to_i)}.to_a).to eq(expected)
  end

  it 'gets a list of elves and their calories' do
    expect(subject.elves('day_01/01_calories_sample.txt')).to eq([6000,4000,11000,24000,10000])
  end

  it 'can find the top elf a long list' do
    expect(subject.elves('day_01/01_calories_input.txt').max).to eq(69501)
  end

  it 'can find the top three elves' do
    expected = [69501, 66606, 66239]
    actual = subject.elves('day_01/01_calories_input.txt').max(3)
    expect(actual).to eq(expected)
    expect(actual.sum).to eq(202346)
  end
end