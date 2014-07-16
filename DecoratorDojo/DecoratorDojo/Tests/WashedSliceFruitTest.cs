using System;
using DecoratorDojo.Decorators;
using DecoratorDojo.Domain;
using DecoratorDojo.Services;
using NUnit.Framework;
using Should;

namespace DecoratorDojo.Tests
{
	[TestFixture]
	public class WashedSliceFruitTest
	{
		private readonly OutputCaptor _captor = new OutputCaptor();

		[Test]
		public void Can_eat_washed_sliced_fruit()
		{
			Action action = () =>
			                	{
			                		//var washedSlicedFruit = new WashedFruit(new SlicedFruit(new Apple()));

			                		//var x = Wash.Slice().Eat(new Apple());
									// var x Slice.Eat(new Apple());

									//Fruit fruit1 = new Apple();
									//fruit1 = new SlicedFruit(fruit1);
									//washedSlicedFruit = new WashedFruit(fruit1);

			                		new Apple().Slice().Wash().Eat();
			                		//Wash.Slice.Eat(new Apple());

			                		//washedSlicedFruit.Eat();
			                	};

			var result = _captor.CaptureTextFromExecuting(action);
			result.ShouldEqual("Washed the apple" + Environment.NewLine 
				+ "Sliced the apple" + Environment.NewLine 
				+ "Ate the apple" + Environment.NewLine);
		}
	}
}