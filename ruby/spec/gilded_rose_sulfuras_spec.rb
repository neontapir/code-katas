require_relative '../lib/gilded_rose'

describe GildedRose do
  context '#update_quality of Sulfuras' do
    before :all do
      @name = 'Sulfuras, Hand of Ragnaros'
    end

    context 'that is fresh' do
      before :each do
        @items = [LegendaryItem.new(@name, 1, 80)]
        GildedRose.new(@items).update_quality
      end

      it 'does not alter the sell_in value' do
        expect(@items[0].sell_in).to eq 1
      end

      it 'maintains a quality of 80' do
        expect(@items[0].quality).to eq 80
      end
    end

    context 'that is stale' do
      before :each do
        @items = [LegendaryItem.new(@name, 0, 80)]
        GildedRose.new(@items).update_quality
      end

      it 'does not alter the sell_in value' do
        expect(@items[0].sell_in).to eq 0
      end

      it 'maintains a quality of 80' do
        expect(@items[0].quality).to eq 80
      end
    end
  end
end
