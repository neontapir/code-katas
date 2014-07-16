using System;
using DecoratorDojo.Domain;

namespace DecoratorDojo.Decorators
{
	public class WashedFruit : Fruit
	{
		readonly Fruit _fruit;

		public WashedFruit(Fruit fruit) 
			: base(fruit.Name)
		{
			_fruit = fruit;
		}

		public override void Eat()
		{
			Console.WriteLine("Washed the " + _fruit.Name);
			_fruit.Eat();
		}
		 
	}
}