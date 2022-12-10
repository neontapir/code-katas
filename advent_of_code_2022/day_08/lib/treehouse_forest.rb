class TreehouseForest
  attr_reader :grid

  def initialize(file)
    @grid = parse(file)
    @max_index = grid.size - 1
  end

  def visible?(x, y)
    height = grid[x][y]
    
    (0..x-1).all?{|x1| height > grid[x1][y]} || # up
      (0..y-1).all?{|y1| height > grid[x][y1]} || # left
      (y+1..@max_index).all?{|y1| height > grid[x][y1]} || # right
      (x+1..@max_index).all?{|x1| height > grid[x1][y]} # down
  end

  def distance(x, y)
    height = grid[x][y]
    # pp "height of grid[#{x}][#{y}]: #{height}"

    temp = 0
    (0..x-1).to_a.reverse.each do |x1|
      temp += 1 #; pp "grid[#{x1}][#{y}] = #{grid[x1][y]}"
      if height <= grid[x1][y]
        # pp "stop for tree, #{height} <= #{grid[x1][y]}"
        break
      end
    end
    up = temp
    
    temp = 0
    (0..y-1).to_a.reverse.each do |y1| 
      temp += 1; 
      #pp "grid[#{x}][#{y1}] = #{grid[x][y1]}"; 
      if height <= grid[x][y1]
        # pp "stop for tree"
        break
      end
    end 
    left = temp
    
    temp = 0
    (y+1..@max_index).each do |y1| 
      temp += 1; 
      # pp "grid[#{x}][#{y1}] = #{grid[x][y1]}"; 
      if height <= grid[x][y1] 
        # pp "stop for tree"
        break
      end
    end
    right = temp
    
    temp = 0
    (x+1..@max_index).each do |x1| 
      temp += 1; 
      # pp "grid[#{x1}][#{y}] = #{grid[x1][y]}"; 
      if height <= grid[x1][y] 
        # pp "stop for tree"
        break
      end
    end 
    down = temp

    [up, left, right, down]
  end

  def scenic_score(x,y)
    distance(x,y).reduce(1, :*)
  end

  def sum_visible
    sum = 0
    (0..@max_index).each do |x|
      (0..@max_index).each do |y|
        sum += 1 if visible?(x,y)
      end
    end
    sum
  end

  def max_scenic_score
    max_scenic_score = 0
    (0..@max_index).each do |x|
      (0..@max_index).each do |y|
        score = scenic_score(x,y)
        max_scenic_score = score if scenic_score(x,y) > max_scenic_score
      end
    end
    max_scenic_score
  end

  private

  def parse(file)
    grid = []
    File.read(file).lines.each_with_index do |line, index|
      grid[index] = line.chomp.chars.map(&:to_i)
    end
    grid
  end
end
