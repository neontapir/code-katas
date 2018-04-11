require_relative 'item'

class GildedRose
  class ItemWrapper
    def initialize(item)
      @item = item
    end

    def age
      @item.sell_in -= 1
    end
  end

  class AgedBrie < ItemWrapper
    def update
      @item.quality = [50, @item.quality + 1].min
    end
  end

  class BackstagePass < ItemWrapper
    def update
      @item.quality =
        if @item.sell_in.negative?
          0
        else
          extra = case @item.sell_in
                  when 6..10 then 2
                  when 0..5 then 3
                  else 1
                  end
          @item.quality + extra
        end
    end
  end

  class Conjured < ItemWrapper
    def update
      @item.quality = [0, @item.quality - 2].max
    end
  end

  class Legendary < ItemWrapper
    def age; end

    def update
      @item.quality = 80
    end
  end

  class Normal < ItemWrapper
    def update
      @item.quality = [0, @item.quality - 1].max
    end
  end

  SPECIALTY_MAP = {
    'Aged Brie' => AgedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePass,
    'Conjured Mana Cake' => Conjured,
    'Sulfuras, Hand of Ragnaros' => Legendary
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      specialty = (SPECIALTY_MAP[item.name] || Normal).new item
      specialty.update unless item.sell_in.negative?
      specialty.age
      specialty.update if item.sell_in.negative?
    end
  end
end
