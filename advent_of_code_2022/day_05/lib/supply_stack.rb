require_relative 'cranemover_9000'
class SupplyStack
  attr_reader :instructions, :state, :crane

  def initialize(instruction_file, crane = CraneMover9000.new)
    lines = File.readlines(instruction_file)
    divider = lines.find_index{ |l| l == "\n" }
    diagram = lines[0..divider-1]
    @instructions = lines[divider+1..lines.length]
    @state = parse_diagram(diagram)
    @crane = crane
  end

  # Note: Examining the data reveals that the crate columns
  # are always 4n + 2 (columns 2, 6, ...)
  # Ruby arrays are zero-based, so it's 4n + 1
  def parse_diagram(diagram)
    positions = []
    columns = diagram.first.length
    columns_with_data = 1.step(columns, 4)
    diagram.each do |line|
      positions << line.chomp.chars.values_at(*columns_with_data)
    end
    positions.reverse!
    positions.shift # remove stack numbers

    positions.transpose
  end
  
  def transform(input)
    state = strip_spaces

    Array(input).each do |move|
      move_values = parse_move(move)
      state = crane.apply(state, move_values)
    end

    @state = beautify(state)

    self
  end

  def parse_move(move)
    m = move.chomp.match(/move (?<qty>\d+) from (?<src>\d+) to (?<dest>\d+)/)
    [m[:qty].to_i, m[:src].to_i - 1, m[:dest].to_i - 1]
  end

  def strip_spaces
    state = []
    for row in 0...@state.length
      state[row] = @state[row].reject{ |x| x == " " }
    end
    state
  end

  def beautify(state)
    tallest_stack = state.map { |i| i.reject{ |i| i == " " }.join("").length }.max
    # pp "DEBUG: tallest_stack: #{tallest_stack} for #{@state}"
    for row in 0...state.length
      for col in 0...tallest_stack
        state[row][col] ||= " "
      end
    end

    state
  end

  def rearrange
    # pp "DEBUG: instructions: #{instructions}"
    transform(instructions)
  end

  def top_crates
    @state.map { |i| i.reject{ |i| i == " " }.last }.join("")
  end
end
