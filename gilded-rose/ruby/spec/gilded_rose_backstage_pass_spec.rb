require_relative '../lib/gilded_rose'

describe GildedRose do
  context '#update_quality of backstage passes' do
    before :all do
      @name = 'Backstage passes to a TAFKAL80ETC concert'
    end

    context 'as the concert approaches' do
      before :each do
        @items = [BackstagePassItem.new(@name, 20, 30)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq 19
      end

      it 'increases the quality by 1' do
        expect(@items[0].quality).to eq 31
      end
    end

    context 'as the concert is less than 10 days away' do
      before :each do
        @items = [BackstagePassItem.new(@name, 9, 10)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq 8
      end

      it 'increases the quality by 2' do
        expect(@items[0].quality).to eq 12
      end
    end

    context 'as the concert is less than 5 days away' do
      before :each do
        @items = [BackstagePassItem.new(@name, 4, 10)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq 3
      end

      it 'increases the quality by 3' do
        expect(@items[0].quality).to eq 13
      end
    end

    context 'after concert is over' do
      before :each do
        @items = [BackstagePassItem.new(@name, -1, 30)]
        GildedRose.new(@items).update_quality
      end

      it 'decreases the sell_in value by 1' do
        expect(@items[0].sell_in).to eq(-2)
      end

      it 'drops to 0' do
        expect(@items[0].quality).to eq 0
      end
    end
  end
end
