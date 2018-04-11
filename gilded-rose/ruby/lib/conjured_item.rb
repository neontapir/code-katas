require_relative 'aging'
require_relative 'item'

class ConjuredItem < Item
  include Aging

  def update
    @quality = [0, @quality - 2].max
  end
end
