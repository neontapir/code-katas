require_relative('rucksack')

class RucksackSet
  attr_accessor :rucksacks
  include Enumerable

  def initialize(*rucksacks)
    @rucksacks = Array.new(*rucksacks)
    @rucksacks = rucksacks.flatten.map{|r| Rucksack.new(r.to_s.chomp)}
  end

  def each(*args, &block)
    rucksacks.each(*args, &block)
  end

  def priorities_total
    rucksacks.map(&:priorities_sum).sum
  end

  def in_all_rucksacks
    items = rucksacks.map{|r| r.contents.chars}
    items.inject(items.first) {|sum, i| sum.intersection(i) }
  end

  def badge
    in_all_rucksacks
  end

  def badge_priority
    Rucksack.priority(badge)
  end

  def into_triads
    rucksacks.each_slice(3).map{|a| RucksackSet.new(a)}
  end

  def ==(other)
    map{|r| r.contents} == other.map{|r| r.contents}
  end
end