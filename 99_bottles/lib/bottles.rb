class Bottles
  def bottle_handle(number)
    case number
    when 1 then "it"
    else "one"
    end
  end

  def bottles(number)
    case number
    when 0 then "no more bottles"
    when 1 then "1 bottle"
    else "#{number} bottles"
    end
  end

  def bottles_of_beer_line(number)
    "#{bottles(number).capitalize} of beer on the wall, " +
    "#{bottles(number)} of beer.\n"
  end

  def handout_line(number)
    case number
    when 0
      "Go to the store and buy some more, " + 
      "99 bottles of beer on the wall.\n"
    else
      "Take #{bottle_handle(number)} down and pass it around, " +
      "#{bottles(number-1)} of beer on the wall.\n"
    end
  end

  def verse(number)
    bottles_of_beer_line(number) + handout_line(number)
  end

  def verses(first,last)
    first.downto(last).map{|i| verse(i)}.join("\n")
  end

  def song
    verses(99,0)
  end
end