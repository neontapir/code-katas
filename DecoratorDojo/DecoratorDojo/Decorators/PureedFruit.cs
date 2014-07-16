using System;
using DecoratorDojo.Domain;

namespace DecoratorDojo.Decorators
{
	public class PureedFruit : Fruit
	{
		readonly Fruit _fruit;

		public PureedFruit(Fruit fruit)
			: base(fruit.Name)
		{
			_fruit = fruit;
		}

		public override void Eat()
		{
			Console.WriteLine("Pureed the " + _fruit.Name);
			_fruit.Eat();

		}
	}
}