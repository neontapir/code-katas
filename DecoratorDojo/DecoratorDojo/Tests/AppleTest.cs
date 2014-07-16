using System;
using DecoratorDojo.Domain;
using DecoratorDojo.Services;
using NUnit.Framework;
using Should;

namespace DecoratorDojo.Tests
{
	[TestFixture]
	public class AppleTest
	{
		private readonly OutputCaptor _captor = new OutputCaptor();

		[Test]
		public void Can_eat_apple()
		{
			Action action = () =>
			                	{
			                		var apple = new Apple();
			                		apple.Eat();
			                	};

			var result = _captor.CaptureTextFromExecuting(action);
			result.ShouldEqual("Ate the apple" + Environment.NewLine);
		}
	}
}