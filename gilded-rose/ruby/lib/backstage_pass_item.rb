require_relative 'aging'
require_relative 'item'

class BackstagePassItem < Item
  include Aging

  def update
    @quality =
      if @sell_in.negative?
        0
      else
        extra = case @sell_in
                when 6..10 then 2
                when 0..5 then 3
                else 1
                end
        @quality + extra
      end
  end
end
