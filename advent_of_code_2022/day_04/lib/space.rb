class Space
  attr_reader :assignments, :ranges

  def initialize(assignments)
    @assignments = assignments
    @ranges = to_ranges
  end

  def to_ranges
    assignments
      .split(',')
      .map do |part|
        start, finish = part.split('-')
        Range.new(start.to_i, finish.to_i)
      end
  end

  def ==(other)
    assignments == other.assignments
  end

  def full_overlap?
    range1, range2 = ranges
    range1.cover?(range2) || range2.cover?(range1)
  end

  def partial_overlap?
    range1, range2 = ranges
    range1.to_a.any? { |n| range2.include?(n) }
  end
end