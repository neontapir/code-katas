using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace PrimeFactorsKata
{
	public class PrimeFactors
	{
		public int CalculateFor(int i)
		{
			return i;
		}
	}

	[TestClass]
	public class PrimeFactorsTest
	{
		[TestMethod]
		public void TestOne()
		{
			Assert.AreEqual(1, new PrimeFactors().CalculateFor(1));
		}
	}
}
