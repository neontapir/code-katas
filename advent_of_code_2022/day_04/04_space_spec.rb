require 'rspec'
require_relative 'lib/space'
require_relative 'lib/space_set'

describe Space do
  it 'can parse an assigment' do
    expect(Space.new('2-4,6-8').assignments).to eq '2-4,6-8'
    expect(Space.new('2-4,6-8').ranges).to eq [2..4, 6..8]
  end

  it 'can detect a full overlap' do
    expect(Space.new('2-4,6-8').full_overlap?).to be_falsey
    expect(Space.new('6-6,6-8').full_overlap?).to be_truthy
  end

  it 'can detect a partial overlap' do
    expect(Space.new('5-6,6-8').partial_overlap?).to be_truthy
    expect(Space.new('6-6,6-8').partial_overlap?).to be_truthy
    expect(Space.new('2-5,6-8').partial_overlap?).to be_falsey
  end
end

context 'part 1 sample set' do
  subject(:assignmentPairs) { SpaceSet.new(File.readlines("day_04/day_04_sample.txt")) }

  it 'can hydrate pairings' do
    expect(assignmentPairs.first).to eq Space.new('2-4,6-8')
  end

  it 'can find all full overlaps' do
    expect(assignmentPairs.filter{|p| p.full_overlap?}.map{|p| p.assignments}).to eq ["2-8,3-7", "6-6,4-6"]
  end
end

context 'part 1 input set' do
  subject(:assignmentPairs) { SpaceSet.new(File.readlines("day_04/day_04_input.txt")) }

  it 'can count full overlaps' do
    expect(assignmentPairs.full_overlaps.count).to eq 498
  end
end

context 'part 2 input set' do
  subject(:assignmentPairs) { SpaceSet.new(File.readlines("day_04/day_04_input.txt")) }

  it 'can count partial overlaps' do
    expect(assignmentPairs.partial_overlaps.count).to eq 859
  end
end