require_relative '../lib/gilded_rose'
Dir[File.join(__dir__, 'gilded_rose_*_spec.rb')].each { |file| require file }

describe GildedRose do
  context '#update_quality of any item' do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "does not increase the quality above 50" do
      # Aged Brie increases in quality as it ages
      items = [Item.new('Aged Brie', 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it "does not reduce the quality below 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end
end
