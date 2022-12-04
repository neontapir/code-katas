class Rucksack
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def compartments
    items = contents.chars
    half = items.size / 2
    items.each_slice(half).to_a
  end

  def in_both_compartments
    compartments[0].intersection(compartments[1])
  end

  def self.priority(item)
    char = item.first
    result = (char.downcase.ord - 'a'.ord) + 1
    result += 26 if ('A'..'Z').include? char
    result
  end

  def priorities_sum
    in_both_compartments.map{|i| Rucksack.priority(i)}.sum
  end

  def to_s
    contents
  end

  def ==(other)
    contents == other.contents
  end
end