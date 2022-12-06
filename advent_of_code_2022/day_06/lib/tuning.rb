class Tuning
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def find_start(size)
    marker = message.chars.each_cons(size).find {|seq| seq.uniq == seq }.join('')
    message.index(marker) + size
  end

  def packet_start
    find_start(4)
  end

  def message_start
    find_start(14)
  end
end