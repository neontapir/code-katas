require_relative '../lib/gilded_rose'

describe GildedRose do
  context '#update_quality of a conjured item' do
    before :all do
      @name = 'Conjured Mana Cake'
    end

    context 'that is fresh' do
      before :each do
        @items = [Item.new(@name, 1, 50)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq 0
      end

      it 'decreases the quality by twice 1' do
        expect(@items[0].quality).to eq 48
      end
    end

    context 'that is stale' do
      before :each do
        @items = [Item.new(@name, 0, 50)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq(-1)
      end

      it 'decreases the quality by twice twice 1' do
        expect(@items[0].quality).to eq 46
      end
    end
  end
end
