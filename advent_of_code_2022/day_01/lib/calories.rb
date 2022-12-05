class Calories
  def elves(file)
    elves = File.open(file).each_line.map(&:chomp)
    elves
      .slice_when{|i,j| j == ''}
      .map{|i| i.map(&:to_i).sum}
  end
end