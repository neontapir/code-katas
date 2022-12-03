class FirstDecoder
  def to_shape(code)
    case code
    when 'A', 'X' then :rock
    when 'B', 'Y' then :paper
    when 'C', 'Z' then :scissors
    end
  end

  def decode(encoded_round)
    them_code, us_code = encoded_round.split(' ')
    [to_shape(them_code), to_shape(us_code)]
  end
end