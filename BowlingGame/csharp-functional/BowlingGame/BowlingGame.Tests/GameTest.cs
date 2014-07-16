using System;
using BowlingGame.Core;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BowlingGame.Tests
{
	[TestClass]
	public class GameTest
	{
		Game g;

		[TestInitialize]
		public void SetUp()
		{
			g = new Game();
		}

		[TestMethod]
		public void TestGutterGame()
		{
			RollMany(20, 0);
			Assert.AreEqual(0, g.Score());
		}

		[TestMethod]
		public void TestAllOnes()
		{
			RollMany(20, 1);
			Assert.AreEqual(20, g.Score());
		}

		[TestMethod]
		public void TestOneSpare()
		{
			RollSpare();
			g.Roll(3);
			RollMany(17,0);
			Assert.AreEqual(16, g.Score());
		}

		[TestMethod]
		public void TestOneStrike()
		{
			RollStrike();
			g.Roll(4);
			g.Roll(3);
			Assert.AreEqual(24, g.Score());
		}

		[TestMethod]
		public void TestPerfectGame()
		{
			RollMany(12, 10);
			Assert.AreEqual(300, g.Score());
		}

		private void RollStrike()
		{
			g.Roll(10);
		}

		private void RollSpare()
		{
			g.Roll(5);
			g.Roll(5); 
		}

		private void RollMany(int times, int pins)
		{
			for (int i = 0; i < times; i++)
			{
				g.Roll(pins);
			}
		}
	}
}
