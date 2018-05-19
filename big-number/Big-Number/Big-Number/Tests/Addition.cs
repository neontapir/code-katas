using Xunit;

namespace Big_Number
{
	public class Addition
	{
		[Fact]
		public void Can_add_two_numbers_without_carrying()
		{
			Big_Number x = new Big_Number("2");
			Big_Number y = new Big_Number("7");
			Assert.Equal(new Big_Number("9"), x + y);
		}

		[Fact]
        public void Can_add_two_numbers_of_different_sizes_without_carrying()
        {
            Big_Number x = new Big_Number("12");
            Big_Number y = new Big_Number("6");
			Assert.Equal(new Big_Number("18"), x + y);
        }

		[Fact]
		public void Can_add_two_multiple_digit_numbers_without_carrying()
		{
			Big_Number x = new Big_Number("13");
			Big_Number y = new Big_Number("26");
			Assert.Equal(new Big_Number("39"), x + y);
		}

		[Fact]
        public void Can_add_two_numbers_with_carrying()
        {
            Big_Number x = new Big_Number("18");
            Big_Number y = new Big_Number("72");
			Assert.Equal(new Big_Number("90"), x + y);
        }

		[Fact]
        public void Can_add_two_big_numbers()
        {
			Big_Number x = new Big_Number("1234567890123456789012345678901234567890");
			Big_Number y = new Big_Number("1234567890123456789012345678901234567890");
			Assert.Equal(new Big_Number("2469135780246913578024691357802469135780"), x + y);
        }
    }
}
