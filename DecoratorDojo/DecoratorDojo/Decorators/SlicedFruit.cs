using System;
using DecoratorDojo.Domain;

namespace DecoratorDojo.Decorators
{
	public class Sliced<T> : Fruit where T : Food
	{
		readonly T _fruit;

		public Sliced(T fruit)
			: base(fruit.Name)
		{
			_fruit = fruit;
		}

		public override void Eat()
		{
			Console.WriteLine("Sliced the " + _fruit.Name);
			_fruit.Eat();
		}
	}
}