using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Gilded_Rose;
using System.Collections.Generic;

namespace Gilded_Rose_Test
{
    [TestClass]
    public class GildedRoseTest
    {
        [TestMethod]
        public void GenericItemQualityReducesByOneAtEndOfEachDayWhileSellInHasNotPassed()
        {
            // given
            GildedRose.Items = new List<Item>
            {
                new Item(ItemType.Generic, "Leather Armor", 10, 20)
            };
            // when
            GildedRose.updateQuality();
            // then
            var expectedQuality = 19;
            var actualQuality = GildedRose.Items[0].Quality;
            Assert.AreEqual(expectedQuality, actualQuality);
        }
    }
}
