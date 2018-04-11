require_relative '../lib/gilded_rose'

describe GildedRose do
  context '#update_quality of Aged Brie' do
    before :all do
      @name = 'Aged Brie'
    end

    context 'that is fresh' do
      before :each do
        @items = [AgedBrieItem.new(@name, 1, 20)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq 0
      end

      it 'increases the quality by 1' do
        expect(@items[0].quality).to eq 21
      end
    end

    context 'that is stale' do
      before :each do
        @items = [AgedBrieItem.new(@name, 0, 20)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq(-1)
      end

      it 'increases the quality by twice 1' do
        expect(@items[0].quality).to eq 22
      end
    end
  end
end
