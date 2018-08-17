namespace Gilded_Rose
{
    public class Item
    {
        public ItemType Type { get; set; }
        public string Name { get; set; }
        public int SellIn;
        public int Quality;

        public Item(ItemType type, string name, int sellIn, int quality)
        {
            this.Type = type;
            this.Name = name;
            this.SellIn = sellIn;
            this.Quality = quality;
        }
    }

    public enum ItemType
    {
        Generic,
        Aging,
        Sulfurus,
        Tickets


    }
}