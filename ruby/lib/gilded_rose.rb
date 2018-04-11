require_relative 'item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'
      update_item_quality(item) unless item.sell_in.negative?
      age_item(item)
      update_item_quality(item) if item.sell_in.negative?
    end
  end

  def update_item_quality(item)
    item.quality =
      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        if item.sell_in.negative?
          0
        else
          extra = case item.sell_in
                  when 6..10 then 2
                  when 0..5 then 3
                  else 1
                  end
          item.quality + extra
        end
      elsif item.name == 'Aged Brie'
        [50, item.quality + 1].min
      else
        [0, item.quality - 1].max
      end
  end

  def age_item(item)
    item.sell_in -= 1
  end
end
