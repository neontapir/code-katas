require_relative 'aging'
require_relative 'item'

class NormalItem < Item
  include Aging

  def update
    @quality = [0, @quality - 1].max
  end
end
