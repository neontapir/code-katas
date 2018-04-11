require_relative 'aging'
require_relative 'item'

class AgedBrieItem < Item
  include Aging

  def update
    @quality = [50, @quality + 1].min
  end
end
