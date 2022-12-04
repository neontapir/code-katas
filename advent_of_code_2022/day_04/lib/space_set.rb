require_relative 'space'

class SpaceSet
  attr_accessor :assignmentPairs
  include Enumerable

  def initialize(*assignmentPairs)
    @assignmentPairs = Array.new(*assignmentPairs)
    @assignmentPairs = assignmentPairs.flatten.map{|pair| Space.new(pair.to_s.chomp)}
  end

  def each(*args, &block)
    assignmentPairs.each(*args, &block)
  end

  def full_overlaps
    assignmentPairs.filter{|p| p.full_overlap?}
  end

  def partial_overlaps
    assignmentPairs.filter{|p| p.partial_overlap?}
  end
end