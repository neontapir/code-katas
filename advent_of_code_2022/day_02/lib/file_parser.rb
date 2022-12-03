require_relative 'rock_paper_scissors'

class FileParser
  def to_total(file, decoder_class)
    decoder = decoder_class.new
    rounds = File.readlines(file).map{|line| decoder.decode(line)}
    RockPaperScissors.new.total(rounds)
  end
end