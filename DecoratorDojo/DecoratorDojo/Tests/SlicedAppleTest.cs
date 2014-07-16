using System;
using DecoratorDojo.Decorators;
using DecoratorDojo.Domain;
using DecoratorDojo.Services;
using NUnit.Framework;
using Should;

namespace DecoratorDojo.Tests
{
	[TestFixture]
	public class SlicedAppleTest
	{
		private readonly OutputCaptor _captor = new OutputCaptor();

		[Test]
		public void Can_eat_sliced_apple()
		{
			Action action = () =>
			                	{
			                		new Apple().Slice().Eat();
									//Slice.Eat(new Apple());
			                	};

			var result = _captor.CaptureTextFromExecuting(action);
			result.ShouldEqual("Sliced the apple" + Environment.NewLine + "Ate the apple" + Environment.NewLine);
		}
	}

	public static class FoodProcessorExtensions
	{
		public static Fruit Slice(this Fruit fruit)
		{
			return new Sliced<Fruit>(fruit);
		}

		public static Fruit Wash(this Fruit fruit)
		{
			return new WashedFruit(fruit);
		}

		//public static Fruit Wash(this Sliced<Fruit> fruit)
		//{
		//    return new Sliced<Fruit>(new WashedFruit(Fruit.Create(fruit.Name)));
		//}

		public static Fruit Puree(this Fruit fruit)
		{
			return new PureedFruit(fruit);
		}
	}

	//public class Slice
	//{
	//    public static void Eat(Fruit fruit)
	//    {
	//        new SlicedFruit(fruit).Eat();
	//    }
	//}

	//public class Wash
	//{
	//    public static void Eat(Fruit fruit)
	//    {
	//        new WashedFruit(fruit).Eat();
	//    }

	//    public class Slice
	//    {
	//        public static void Eat(Fruit fruit)
	//        {
	//            new WashedFruit(new SlicedFruit(fruit)).Eat();
	//        }
	//    }
	//}

	//public class Puree
	//{
	//    public static void Eat(Fruit fruit)
	//    {
	//        new PureedFruit(fruit).Eat();
	//    }
	//}
}