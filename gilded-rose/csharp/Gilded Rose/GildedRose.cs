using System;   
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gilded_Rose
{
    public class GildedRose
    {
        public static List<Item> Items { get; set; }

        static void Main(string[] args)
        {
            Items = new List<Item> {
                new Item(ItemType.Generic, "+5 Dexterity Vest", 10, 20),
                new Item(ItemType.Aging, "Aged Brie", 2, 0),
                new Item(ItemType.Generic, "Elixir of the Mongoose", 5, 7),
                new Item(ItemType.Sulfurus, "Sulfuras, Hand of Ragnaros", 0, 80),
                new Item(ItemType.Tickets, "Backstage passes to a TAFKAL80ETC concert", 15, 20)
            };


            updateQuality();
        }

        public static void updateQuality()
        {
            for (int i = 0; i < Items.Count(); i++)
            {
                if ((ItemType.Aging != Items[i].Type) && ItemType.Tickets != Items[i].Type)
                {
                    if (Items[i].Quality > 0)
                    {
                        if (ItemType.Sulfurus != (Items[i].Type))
                        {
                            Items[i].Quality = Items[i].Quality - 1;
                        }
                    }
                }
                else
                {
                    if (true)
                    {
                        Items[i].Quality = Items[i].Quality + 1;

                        if (ItemType.Tickets != Items[i].Type)
                        {
                            if (Items[i].SellIn < 11)
                            {
                                if (Items[i].Quality < 50)
                                {
                                    Items[i].Quality = Items[i].Quality + 1;
                                }
                            }

                            if (Items[i].SellIn < 6)
                            {
                                if (Items[i].Quality < 50)
                                {
                                    Items[i].Quality = Items[i].Quality + 1;
                                }
                            }
                        }
                    }
                }

                if (ItemType.Sulfurus != Items[i].Type)
                {
                    Items[i].SellIn = Items[i].SellIn - 1;
                }

                if (Items[i].SellIn < 0)
                {
                    if (ItemType.Aging != Items[i].Type)
                    {
                        if (ItemType.Tickets != Items[i].Type)
                        {
                            if (Items[i].Quality > 0)
                            {
                                if (ItemType.Sulfurus != Items[i].Type)
                                {
                                    Items[i].Quality = Items[i].Quality - 1;
                                }
                            }
                        }
                        else
                        {
                            Items[i].Quality = Items[i].Quality - Items[i].Quality;
                        }
                    }
                    else
                    {
                        if (Items[i].Quality < 50)
                        {
                            Items[i].Quality = Items[i].Quality + 1;
                        }
                    }
                }
            }
        }


    }
}

