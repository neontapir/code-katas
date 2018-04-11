Dir[File.join(__dir__, '*item.rb')].each { |file| require_relative file }

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      throw "Do not know how to update quality of #{item}" unless item.respond_to?(:age) && item.respond_to?(:update)
      item.update unless item.sell_in.negative?
      item.age
      item.update if item.sell_in.negative?
    end
  end
end
