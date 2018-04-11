require_relative 'item'

class LegendaryItem < Item
  def initialize(name, sell_in, quality)
    super(name, sell_in, quality)
  end

  def age; end

  def update; end
end
