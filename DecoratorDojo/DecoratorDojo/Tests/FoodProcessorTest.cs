using System;
using DecoratorDojo.Decorators;
using DecoratorDojo.Domain;
using DecoratorDojo.Services;
using NUnit.Framework;
using Should;

namespace DecoratorDojo.Tests
{
	[TestFixture]
	public class FoodProcessorTest
	{
		private readonly OutputCaptor _captor = new OutputCaptor();

		[Test]
		public void Can_eat_pureed_apple()
		{
			Action action = () =>
			                	{
			                		var pureedApple = new PureedFruit(new Apple());
			                		pureedApple.Eat();
			                	};

			var result = _captor.CaptureTextFromExecuting(action);
			result.ShouldEqual("Pureed the apple" + Environment.NewLine + "Ate the apple" + Environment.NewLine);
		}
	}
}